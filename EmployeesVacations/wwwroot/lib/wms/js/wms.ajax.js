(function (addon) {
	if (!window.WMS)
		throw new Error('Requires WMS Core');
	else
		addon(window.WMS, window.WMS.$);
})(function (WMS, $) {

	'use strict';

	function parseURL(url, hash) {
		var a = document.createElement('a');
		a.href = url;
		if (hash) a.hash = hash;
		return a;
	}

	function locationReplace(url) {
		window.history.replaceState(null, "", WMS.Ajax.State.url);
		window.location.replace(url);
	}

	function abortXHR(xhr) {
		if (xhr && xhr.readyState < 4) {
			xhr.onreadystatechange = $.noop;
			xhr.abort();
		}
	}

	function stripHash(location) {
		return location.href.replace(/#.*/, '');
	}

	// TODO: Add ajax push setting and implementation to pjax function
	WMS.Ajax = function (url, options) {
		options = $.extend(true, {}, $.ajaxSettings, WMS.Ajax.Settings, WMS.Utils.DataFor('url', url, options));

		if ($.isFunction(options.url))
			options.url = options.url();

		var container = options.container;
		if (WMS.IsDefined(container) && !WMS.IsString(container))
			throw "expected string value for 'container' option";

		var pjax = options.push || options.replace || options._pjax;
		var context = options.context = $(options.container);
		if (pjax && !context.length)
			throw "the container selector '" + options.container + "' did not match anything";
		context.selector = container;

		function fire(type, args, props) {
			if (!context.length) return;
			if (!props) props = {};
			props.relatedTarget = options.target;
			var event = $.Event(type, props);
			context.trigger(event, args);
			return !event.isDefaultPrevented();
		}

		var hash = parseURL(options.url).hash;
		var timeoutTimer;

		var beforeSendFn = options.beforeSend;
		options.beforeSend = function (xhr, settings) {
			// No timeout for non-GET requests
			// Its not safe to request the resource again with a fallback method.
			if (settings.type !== 'GET')
				settings.timeout = 0;

			xhr.setRequestHeader('X-AJAX', 'true');
			if (pjax)
				xhr.setRequestHeader('X-PJAX', 'true');
			if (context.length)
				xhr.setRequestHeader('X-AJAX-Container', container);

			if (WMS.Ajax.Security.XsrfRequestToken && !WMS.Ajax.Security.XsrfIgnoreMethods.contains(settings.type))
				xhr.setRequestHeader(WMS.Ajax.Security.XsrfHeaderName, ($.isFunction(WMS.Ajax.Security.XsrfRequestToken) ? WMS.Ajax.Security.XsrfRequestToken() : WMS.Ajax.Security.XsrfRequestToken));

			if (($.isFunction(beforeSendFn) && beforeSendFn(xhr, settings) === false) | fire('ajax:beforeSend', [xhr, settings]) === false)
				return false;

			if (settings.timeout > 0) {
				timeoutTimer = setTimeout(function () {
					if (fire('ajax:timeout', [xhr, options]))
						xhr.abort('timeout');
				}, settings.timeout);

				// Clear timeout setting so jquerys internal timeout isn't invoked
				settings.timeout = 0;
			}

			options.requestTarget = parseURL(settings.url, hash);
			options.requestUrl = options.requestTarget.href;

			WMS.UI.LoadingSpinner.Show();
		}

		var completeFn = options.complete;
		options.complete = function (xhr, textStatus) {
			if (timeoutTimer)
				clearTimeout(timeoutTimer);

			fire('ajax:complete', [xhr, textStatus, options]);
			//fire('pjax:end', [xhr, options])
			if ($.isFunction(completeFn)) completeFn(xhr, textStatus, options);
			WMS.UI.LoadingSpinner.Hide();
		}

		var errorFn = options.error;
		options.error = function (xhr, textStatus, errorThrown) {
			var allowed = (($.isFunction(errorFn) && errorFn(xhr, textStatus, errorThrown, options) === false) | fire('ajax:error', [xhr, textStatus, errorThrown, options]) === false);
			if (!allowed && options.type == 'GET' && textStatus !== 'abort' && pjax) {
				setTimeout(function () { locationReplace(options.requestUrl); }, 2000);
				WMS.UI.Notify("Error... Page will reload!", { status: 'danger' });
			} else if (!allowed && textStatus !== 'abort') {
				WMS.UI.Notify("Error... Please try again!", { status: 'danger' });
			}
		}

		var successFn = options.success;
		var beforeReplaceFn = options.beforeReplace;
		var afterReplaceFn = options.afterReplace;
		var replaceCompleteFn = options.replaceComplete;
		options.success = function (data, status, xhr) {
			// If $.pjax.defaults.version is a function, invoke it first.
			// Otherwise it can be a static string.
			//var currentVersion = (typeof $.pjax.defaults.version === 'function') ?
			//  $.pjax.defaults.version() :
			//  $.pjax.defaults.version
			//var latestVersion = xhr.getResponseHeader('X-PJAX-Version')

			//var url = options.requestUrl;

			// If there is a layout version mismatch, hard load the new url
			//if (currentVersion && latestVersion && currentVersion !== latestVersion) {
			//	locationReplace(container.url)
			//	return
			//}

			// If the new response is missing a body, hard load the page
			//if (!container.contents) {
			//	locationReplace(container.url)
			//	return
			//}

			if (context.length) {
				var ctnr = WMS.Document.ExtractContainer(data, options.fragment); //extractContainer(data, xhr, options)
				var previousState = WMS.Ajax.State;

				if (pjax) {
					if (!ctnr.contents) {
						locationReplace(options.requestUrl)
						return
					}

					WMS.Ajax.State = {
						id: options.id || WMS.Utils.UId(),
						url: options.requestUrl,
						title: ctnr.title,
						container: options.container,
						fragment: options.fragment,
						timeout: options.timeout
					}

					window.history.replaceState(WMS.Ajax.State, ctnr.title || "", options.requestUrl);
				}

				// Only blur the focus if the focused element is within the container.
				var blurFocus = $.contains(context, document.activeElement);
				// Clear out any focused controls before inserting new page contents.
				if (blurFocus) {
					try {
						document.activeElement.blur();
					} catch (e) { }
				}

				//if (container.title) document.title = container.title;

				fire('ajax:beforeReplace', [ctnr, options], (pjax ? { state: WMS.Ajax.State, previousState: previousState } : {}));
				if ($.isFunction(beforeReplaceFn)) beforeReplaceFn(ctnr, options);
				WMS.Document.ReplaceContents(context, ctnr, {
					afterReplace: function () {
						fire('ajax:afterReplace', [ctnr, options]);
						if ($.isFunction(afterReplaceFn)) afterReplaceFn(ctnr, options);
					},
					complete: function () {
						// FF bug: Won't autofocus fields that are inserted via JS.
						// This behavior is incorrect. So if theres no current focus, autofocus
						// the last field.
						//
						// http://www.w3.org/html/wg/drafts/html/master/forms.html
						var autofocusEl = context.find('input[autofocus], textarea[autofocus]').last()[0];
						if (autofocusEl && document.activeElement !== autofocusEl)
							autofocusEl.focus();

						WMS.Document.ExecuteScriptTags(ctnr.scripts);

						var scrollTo = options.scrollTo;

						// Ensure browser scrolls to the element referenced by the URL anchor
						if (hash) {
							var name = decodeURIComponent(hash.slice(1));
							var target = document.getElementById(name) || document.getElementsByName(name)[0];
							if (target) scrollTo = $(target).offset().top;
						}

						if (WMS.IsNumber(scrollTo)) WMS.$window.scrollTop(scrollTo);

						fire('ajax:replaceComplete', [ctnr, options]);
						if ($.isFunction(replaceCompleteFn)) replaceCompleteFn(ctnr, options);
					}
				});
			}

			fire('ajax:success', [data, status, xhr, options]);
			if ($.isFunction(successFn)) successFn(data, status, xhr, options);
		}

		if (pjax) {
			// Initialize pjax.state for the initial page load. Assume we're
			// using the container and options of the link we're loading for the
			// back button to the initial page. This ensures good back button
			// behavior.
			if (!WMS.Ajax.State) {
				WMS.Ajax.State = {
					id: WMS.Utils.UId(),
					url: window.location.href,
					title: document.title,
					container: context.selector,
					fragment: options.fragment,
					timeout: options.timeout
				};
				window.history.replaceState(WMS.Ajax.State, WMS.Ajax.State.title);
			}

			// Cancel the current request if we're already pjaxing
			abortXHR(WMS.Ajax.xhr);
		}

		//pjax.options = options
		var xhr = WMS.$ajax(options);

		if (pjax) {
			WMS.Ajax.xhr = xhr;

			if (xhr.readyState > 0 && options.push && !options.replace) {
				// Cache current container element before replacing it
				cachePush(WMS.Ajax.State.id, WMS.Document.CloneContents(context));

				window.history.pushState(null, "", options.requestUrl);
			}
		}

		return xhr;
	}

	WMS.Ajax.Settings = {
		timeout: 0,
		push: false,
		replace: false,
		//type: 'GET',
		//dataType: 'html',
		scrollTo: false,
		maxCacheLength: 0,
		//version: findVersion
	}
	WMS.Ajax.Security = {
		XsrfRequestToken: null,
		XsrfHeaderName: 'X-CSRF-TOKEN',
		XsrfIgnoreMethods: ['GET', 'HEAD', 'OPTIONS', 'TRACE']
	};

	// TODO: Add more options
	WMS.Ajax.Action = function (url, action, options) {
		var data = WMS.Utils.DataFor('action', action, options.data);

		WMS.Ajax({
			type: "POST",
			dataType: "json",
			url: url,
			data: data,
			success: function (respond) {
				if (($.isDefined(options.notify) ? options.notify : true) && $.isDefined(respond.msg) && $.isDefined(respond.result))
					WMS.UI.Notify(respond.msg, respond.result);

				if ($.isFunction(options.success)) options.success(respond);
			},
			error: function () {
				if ($.isFunction(options.error)) options.error();
			},
			complete: function () {
				if ($.isFunction(options.complete)) options.complete();
			}
		});
	}

		// TODP: Improvements
	WMS.Ajax.Form = function (form, options) {
		return $(form).each(function () {
			var thisForm = $(this);
			var opts = $.extend({}, WMS.Ajax.Form.Settings, options);
			opts.url = opts.url || thisForm.attr('action') || "/";
			opts.type = opts.type || thisForm.attr('method') || "POST";
			var formInputs, formSubmit, oldSubmitText;

			var finishFunc = function (respond) {
				var s = $.isDefined(respond.result) && (respond.result > 0);

				if (opts.notify && $.isDefined(respond.msg) && $.isDefined(respond.result) && respond.result >= 0)
					WMS.UI.Notify(respond.msg, respond.result);

				formSubmit.html(s ? opts.successText : opts.errorText);
				window.setTimeout(function () {
					formSubmit.html(oldSubmitText);
					formInputs.prop("disabled", false);
				}, 5000);

				if (s) {
					if ($.isFunction(opts.success)) opts.success(respond);
					thisForm.trigger("ajax:success", [respond, opts]);
				} else {
					if ($.isFunction(opts.error)) opts.error(respond);
					thisForm.trigger("ajax:error", [respond, opts]);
				}
			};

			$.validator.unobtrusive.parse(thisForm);
			thisForm.$ajaxForm({
				url: opts.url,
				type: opts.type,
				dataType: opts.dataType,
				data: opts.data,
				beforeSerialize: function ($form) {
					thisForm = $form;
					formInputs = $(':input', thisForm).add(opts.inputs);
					formSubmit = $(':submit', thisForm).add(opts.submit);
				},
				beforeSubmit: function () {
					oldSubmitText = formSubmit.html();
					formInputs.prop("disabled", true);
					formSubmit.html(opts.loadingText);
				},
				success: function (respond) {
					finishFunc(respond);
				},
				error: function () {
					finishFunc({ msg: "Error... Please try again", result: -1 });
				}
			});
		});
	}
	WMS.Ajax.Form.Settings = {
		dataType: "json",
		loadingText: "Loading...",
		successText: "Success",
		errorText: "Error!",
		notify: true
	}

	WMS.Pjax = function (url, options) {
		return WMS.Ajax($.extend({ _pjax: true }, WMS.Pjax.Settings, WMS.Utils.DataFor('url', url, options)))
	}
	WMS.Pjax.Settings = {
		timeout: 0,
		push: true,
		replace: false,
		type: 'GET',
		dataType: 'html',
	}

	WMS.Ajax.Page = {};

	// TODO: Need alot of improves, better architecture, maube add it to WMS not WMS.Ajax ??
	WMS.Ajax.Page.Settings = {
		wrapper: '#wrapper',
		contentWrapper: '#contentWrapper',
		pageWrapper: '#page-wrapper',
		logo: '#logo',
		navigationTop: '#navigation-top',
		navbarTop: '#navbar-top',
		navbarTopToggle: '#navbar-top-toggle',
		navbarTopLeft: '#navbar-top-left',
		loadingSpinner: '#loading-spinner',
		navbarUserName: '#navbar-user-name'
	}
	WMS.Ajax.Page.CurrentLocation = function () {
		return (location.pathname + location.search + location.hash);
	}
	WMS.Ajax.Page.Get = function (url, success, data) {
		WMS.Ajax({
			url: url,
			data: data,
			success: success
		});
	}
	WMS.Ajax.Page.Load = function (url, container, success, push) {
		url = url || WMS.Ajax.Page.CurrentLocation();
		container = container || WMS.Ajax.Page.Settings.contentWrapper;
		(push ? WMS.Pjax : WMS.Ajax)({
			url: url,
			container: container,
			success: success
		});
	}
	WMS.Ajax.Page.onLoad = function () {
		WMS.UI.LoadingSpinner.Init(WMS.Ajax.Page.Settings.loadingSpinner);
		$(WMS.Ajax.Page.Settings.navigationTop).pjax('a:not([data-action]):not([data-toggle]):not([disabled]):not([data-download-url])', WMS.Ajax.Page.Settings.contentWrapper);
		$(WMS.Ajax.Page.Settings.contentWrapper).pjax('a:not([data-action]):not([data-toggle]):not([disabled]):not([data-download-url]):not([data-ajax-container="contentWrapper"])', WMS.Ajax.Page.Settings.pageWrapper);
		$(WMS.Ajax.Page.Settings.contentWrapper).pjax('a[data-ajax-container="contentWrapper"]', WMS.Ajax.Page.Settings.contentWrapper);
	}
	WMS.Ajax.Page.onResize = function () {
		if (WMS.Window.isSmall || !$(WMS.Ajax.Page.Settings.navbarTop).is(":visible"))
			$(WMS.Ajax.Page.Settings.loadingSpinner).insertAfter(WMS.Ajax.Page.Settings.logo);
		else
			$(WMS.Ajax.Page.Settings.loadingSpinner).insertAfter(WMS.Ajax.Page.Settings.navbarTopLeft);
	}
	WMS.Ajax.Page.Init = function () {
		WMS.$window.on("load", WMS.Ajax.Page.onLoad);
		WMS.$window.resize(WMS.Ajax.Page.onResize);
	}

	function fnPjax(selector, container, options) {
		options = WMS.Utils.DataFor('container', container, options);
		return this.on('click.ajax', selector, function (event) {
			var opts = options;
			if (!opts.container) {
				opts = $.extend({}, options);
				opts.container = $(this).attr('data-ajax-container');
			}
			handleClick(event, opts);
		});
	}
	function handleClick(event, container, options) {
		options = WMS.Utils.DataFor('container', container, options);

		var link = event.currentTarget;
		var $link = $(link);

		if (link.tagName.toUpperCase() !== 'A')
			throw "ajax click requires an anchor element";

		// Middle click, cmd click, and ctrl click should open
		// links in a new tab as normal.
		if (event.which > 1 || event.metaKey || event.ctrlKey || event.shiftKey || event.altKey)
			return;

		// Ignore cross origin links
		if (location.protocol !== link.protocol || location.hostname !== link.hostname)
			return;

		// Ignore case when a hash is being tacked on the current URL
		if (link.href.indexOf('#') > -1 && stripHash(link) == stripHash(location))
			return;

		// Ignore event with default prevented
		if (event.isDefaultPrevented())
			return;

		var defaults = {
			url: link.href,
			container: $link.attr('data-ajax-container'),
			target: link
		}

		var opts = $.extend({}, defaults, options);
		var clickEvent = $.Event('ajax:click');
		$link.trigger(clickEvent, [opts]);

		if (!clickEvent.isDefaultPrevented()) {
			WMS.Pjax(opts);
			event.preventDefault();
			$link.trigger('ajax:clicked', [opts]);
		}
	}
	function handleSubmit(event, container, options) {
		options = WMS.Utils.DataFor('container', container, options)

		var form = event.currentTarget
		var $form = $(form)

		if (form.tagName.toUpperCase() !== 'FORM')
			throw "$.pjax.submit requires a form element"

		var defaults = {
			type: ($form.attr('method') || 'GET').toUpperCase(),
			url: $form.attr('action'),
			container: $form.attr('data-ajax-container'),
			target: form
		}

		if (defaults.type !== 'GET' && window.FormData !== undefined) {
			defaults.data = new FormData(form);
			defaults.processData = false;
			defaults.contentType = false;
		} else {
			// Can't handle file uploads, exit
			if ($(form).find(':file').length) {
				return;
			}

			// Fallback to manually serializing the fields
			defaults.data = $(form).serializeArray();
		}

		WMS.Pjax($.extend({}, defaults, options))

		event.preventDefault()
	}

	var initialPop = true;
	var initialURL = window.location.href;
	var initialState = window.history.state;

	if (initialState && initialState.container)
		WMS.Ajax.State = initialState;
	if ('state' in window.history)
		initialPop = false;

	function onPjaxPopstate(event) {
		// Hitting back or forward should override any pending PJAX request.
		if (!initialPop) {
			abortXHR(WMS.Ajax.xhr);
		}
		if (event.originalEvent) {
			event = event.originalEvent;
		}

		var previousState = WMS.Ajax.State;
		var state = event.state;
		var direction;

		if (state && state.container) {
			// When coming forward from a separate history session, will get an
			// initial pop with a state we are already at. Skip reloading the current
			// page.
			if (initialPop && initialURL == state.url) return;

			if (previousState) {
				// If popping back to the same state, just skip.
				// Could be clicking back from hashchange rather than a pushState.
				if (previousState.id === state.id) return;

				// Since state IDs always increase, we can deduce the navigation direction
				direction = previousState.id < state.id ? 'forward' : 'back';
			}

			var cache = cacheMapping[state.id] || [];
			var containerSelector = cache[0] || state.container;
			var container = $(containerSelector), contents = { title: state.title, contents: cache[1] };

			if (container.length) {
				if (previousState) {
					// Cache current container before replacement and inform the
					// cache which direction the history shifted.
					cachePop(direction, previousState.id, WMS.Document.CloneContents(container));
				}

				//if ($.isFunction(state.popstate)) state.popstate(state, direction);
				container.trigger($.Event('ajax:popstate', {
					state: state,
					direction: direction
				}));

				var options = {
					id: state.id,
					url: state.url,
					container: containerSelector,
					push: false,
					fragment: state.fragment,
					timeout: state.timeout,
					scrollTo: false
				}

				if (contents.contents) {
					WMS.Ajax.State = state;
					container.trigger($.Event('ajax:beforeReplace', {
						state: state,
						previousState: previousState
					}), [contents, options]);

					WMS.Document.ReplaceContents(container, contents, {
						afterReplace: function () {
							container.trigger($.Event('ajax:afterReplace'), [contents, options]);
						},
						complete: function () {
							container.trigger($.Event('ajax:replaceComplete'), [contents, options]);
						}
					});

					//if (state.title) document.title = 
					//container.html(contents)

					//context.trigger('ajax:end', [null, options]);
				} else {
					WMS.Pjax(options);
				}

				// Force reflow/relayout before the browser tries to restore the
				// scroll position.
				container[0].offsetHeight
			} else {
				locationReplace(location.href)
			}
		}
		initialPop = false
	}

	var cacheMapping = {};
	var cacheForwardStack = [];
	var cacheBackStack = [];

	// Push previous state id and container contents into the history
	// cache. Should be called in conjunction with `pushState` to save the
	// previous container contents.
	//
	// id    - State ID Number
	// value - DOM Element to cache
	//
	// Returns nothing.
	function cachePush(id, value) {
		cacheMapping[id] = value;
		cacheBackStack.push(id);

		// Remove all entries in forward history stack after pushing a new page.
		trimCacheStack(cacheForwardStack, 0);

		// Trim back history stack to max cache length.
		trimCacheStack(cacheBackStack, WMS.Ajax.Settings.maxCacheLength);
	}

	// Shifts cache from directional history cache. Should be
	// called on `popstate` with the previous state id and container
	// contents.
	//
	// direction - "forward" or "back" String
	// id        - State ID Number
	// value     - DOM Element to cache
	//
	// Returns nothing.
	function cachePop(direction, id, value) {
		var pushStack, popStack;
		cacheMapping[id] = value;

		if (direction === 'forward') {
			pushStack = cacheBackStack;
			popStack = cacheForwardStack;
		} else {
			pushStack = cacheForwardStack;
			popStack = cacheBackStack;
		}

		pushStack.push(id);
		if (id = popStack.pop())
			delete cacheMapping[id];

		// Trim whichever stack we just pushed to to max cache length.
		trimCacheStack(pushStack, WMS.Ajax.Settings.maxCacheLength);
	}

	// Trim a cache stack (either cacheBackStack or cacheForwardStack) to be no
	// longer than the specified length, deleting cached DOM elements as necessary.
	//
	// stack  - Array of state IDs
	// length - Maximum length to trim to
	//
	// Returns nothing.
	function trimCacheStack(stack, length) {
		while (stack.length > length)
			delete cacheMapping[stack.shift()];
	}

	WMS.Ajax.Init = function () {

		WMS.$ajax = $.ajax;
		$.ajax = WMS.Ajax;
		$.fn.pjax = fnPjax;
		$.fn.$ajaxForm = $.fn.ajaxForm;
		$.fn.ajaxForm = function (options) {
			WMS.Ajax.Form(this, options)
		}

		WMS.$window.on('popstate.ajax', onPjaxPopstate);

	}

	return WMS.Ajax;
});