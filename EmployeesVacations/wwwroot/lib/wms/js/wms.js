(function (core) {
	if (!window.jQuery)
		throw new Error('Requires jQuery');
	else
		core(window.jQuery);
})(function ($) {

	'use strict';

	if (window.WMS)
		return window.WMS;

	var WMS = {};

	window.WMS = WMS;

	WMS.IsDefined = function (value) {
		return value != undefined;
	}
	WMS.IsUndefined = function (value) {
		return typeof value === 'undefined';
	}
	WMS.IsString = function (value) {
		return typeof value === 'string';
	}
	WMS.IsNotEmptyString = function (value) {
		return $.isString(value) && value !== "";
	}
	WMS.IsNumber = function (value) {
		return typeof value === 'number';
	}
	WMS.IsBoolean = function (value) {
		return typeof value === 'boolean';
	}
	WMS.IsArray = Array.isArray;

	$.isDefined = WMS.IsDefined;
	$.isUndefined = WMS.IsUndefined;
	$.isString = WMS.IsString;
	$.isNotEmptyString = WMS.IsNotEmptyString;
	$.isNumber = WMS.IsNumber;
	$.isBoolean = WMS.IsBoolean;
	$.isArray = WMS.IsArray;

	String.prototype.escapeHtml = function () {
		var entityMap = {
			'&': '&amp;',
			'<': '&lt;',
			'>': '&gt;',
			'"': '&quot;',
			"'": '&#39;',
			'`': '&#x60;',
			'=': '&#x3D;',
			'/': '&#x2F;'
		};

		return this.replace(/[&<>"'`=\/]/g, function (s) {
			return entityMap[s];
		});
	};

	(function () {
		if (!Array.prototype.includes) {
			// https://tc39.github.io/ecma262/#sec-array.prototype.includes
			Object.defineProperty(Array.prototype, 'includes', {
				value: function (searchElement, fromIndex) {

					// 1. Let O be ? ToObject(this value).
					if (this == null) {
						throw new TypeError('"this" is null or not defined');
					}

					var o = Object(this);

					// 2. Let len be ? ToLength(? Get(O, "length")).
					var len = o.length >>> 0;

					// 3. If len is 0, return false.
					if (len === 0) {
						return false;
					}

					// 4. Let n be ? ToInteger(fromIndex).
					//    (If fromIndex is undefined, this step produces the value 0.)
					var n = fromIndex | 0;

					// 5. If n ≥ 0, then
					//  a. Let k be n.
					// 6. Else n < 0,
					//  a. Let k be len + n.
					//  b. If k < 0, let k be 0.
					var k = Math.max(n >= 0 ? n : len - Math.abs(n), 0);

					function sameValueZero(x, y) {
						return x === y || (typeof x === 'number' && typeof y === 'number' && isNaN(x) && isNaN(y));
					}

					// 7. Repeat, while k < len
					while (k < len) {
						// a. Let elementK be the result of ? Get(O, ! ToString(k)).
						// b. If SameValueZero(searchElement, elementK) is true, return true.
						// c. Increase k by 1. 
						if (sameValueZero(o[k], searchElement)) {
							return true;
						}
						k++;
					}

					// 8. Return false
					return false;
				}
			});
		}

		Array.prototype.contains = Array.prototype.includes;
		})();

	WMS.$ = $;
	WMS.$window = $(window);
	WMS.$document = $(document);

	WMS.Support = {};
	WMS.Support.Transition = (function () {
		var transitionEnd = (function () {
			var element = document.body || document.documentElement,
				transEndEventNames = {
					WebkitTransition: 'webkitTransitionEnd',
					MozTransition: 'transitionend',
					OTransition: 'oTransitionEnd otransitionend',
					transition: 'transitionend'
				}, name;

			for (name in transEndEventNames) {
				if (WMS.IsDefined(element.style[name])) return transEndEventNames[name];
			}
		}());

		return transitionEnd && { end: transitionEnd };
	})();
	WMS.Support.Animation = (function () {
		var animationEnd = (function () {
			var element = document.body || document.documentElement,
				animEndEventNames = {
					WebkitAnimation: 'webkitAnimationEnd',
					MozAnimation: 'animationend',
					OAnimation: 'oAnimationEnd oanimationend',
					animation: 'animationend'
				}, name;

			for (name in animEndEventNames) {
				if (WMS.IsDefined(element.style[name])) return animEndEventNames[name];
			}
		}());

		return animationEnd && { end: animationEnd };
	})();

	// requestAnimationFrame polyfill
	//https://github.com/darius/requestAnimationFrame
	(function () {

		Date.now = Date.now || function () { return new Date().getTime(); };

		var vendors = ['webkit', 'moz'];
		for (var i = 0; i < vendors.length && !window.requestAnimationFrame; ++i) {
			var vp = vendors[i];
			window.requestAnimationFrame = window[vp + 'RequestAnimationFrame'];
			window.cancelAnimationFrame = (window[vp + 'CancelAnimationFrame']
				|| window[vp + 'CancelRequestAnimationFrame']);
		}
		if (/iP(ad|hone|od).*OS 6/.test(window.navigator.userAgent) // iOS6 is buggy
			|| !window.requestAnimationFrame || !window.cancelAnimationFrame) {
			var lastTime = 0;
			window.requestAnimationFrame = function (callback) {
				var now = Date.now();
				var nextTime = Math.max(lastTime + 16, now);
				return setTimeout(function () { callback(lastTime = nextTime); },
					nextTime - now);
			};
			window.cancelAnimationFrame = clearTimeout;
		}
	})();

	WMS.Support.Touch = (
		('ontouchstart' in document) ||
		(window.DocumentTouch && document instanceof window.DocumentTouch) ||
		(window.navigator.msPointerEnabled && window.navigator.msMaxTouchPoints > 0) || //IE 10
		(window.navigator.pointerEnabled && window.navigator.maxTouchPoints > 0) || //IE >=11
		false
	);

	WMS.Support.MutationObserver = (window.MutationObserver || window.WebKitMutationObserver || null);

	WMS.Utils = {};

	WMS.Utils.StrVars = function (str, vars) {
		return str.replace(/(^|[^\\]){{([0-9A-Z_\|]*)}}/gi, function (match, p1, p2) {
			var varKeys = p2.split('|');
			for (var i = 0; i < varKeys.length; i++) {
				if ($.isDefined(vars[varKeys[i]]))
					return p1 + vars[varKeys[i]];
			}
			return match;
		}).replace(/\\({{[0-9A-Z_\|]*}})/gi, function (match, p1) {
			return p1;
		});
	}
	WMS.Utils.PropVars = function (obj, vars) {
		for (var prop in obj) {
			if ($.isString(obj[prop]))
				obj[prop] = $.replaceVars(obj[prop], vars);
		}

		return obj;
	}
	WMS.Utils.DataFor = function (varKey, varValue, data) {
		if (varValue && data)
			data[varKey] = varValue;
		else if ($.isPlainObject(varValue))
			data = varValue;
		else {
			data = {};
			data[varKey] = varValue;
		}
		return data;
	}

	WMS.Utils.UId = function () {
		return (new Date).getTime();
	}
	WMS.Utils.StrUId = function (prefix) {
		return (prefix || 'id') + WMS.Utils.UId() + "RAND" + (Math.ceil(Math.random() * 100000));
	}

	WMS.Window = {};
	WMS.Window.Resize = function () {
		WMS.$window.resize();
	}
	WMS.$window.resize(function () {
		WMS.Window.height = WMS.$window.height();
		WMS.Window.width = WMS.$window.width();
		WMS.Window.isSmall = WMS.Ajax.Page.width <= 767;
	});
	WMS.$window.on("load", function () {
		WMS.Window.Resize();
	});

	return WMS;
});
(function (addon) {
	if (!window.WMS)
		throw new Error('Requires WMS Core');
	else
		addon(window.WMS, window.WMS.$);
})(function (WMS, $) {

	'use strict';

	WMS.Document = {};
	WMS.Document.$html = $('html');
	WMS.Document.$body = $('body');

	WMS.Document.Options = {
		DefaultTitle: ""
	};

	$.fn.findAll = function (selector) {
		var elems = $(this);
		return elems.filter(selector).add(elems.find(selector));
	}

	WMS.Document.SetTitle = function (title) {
		document.title = WMS.Document.Options.DefaultTitle + ((WMS.IsNotEmptyString(title)) ? " - " + title : "");
	}

	WMS.Document.ParseHTML = function (html) {
		return $.parseHTML(html, document, true)
	}

	WMS.Document.ExtractContainer = function (data, fragment) {
		var obj = {}, fullDocument = /<html/i.test(data);

		var $head, $body;
		if (fullDocument) {
			$body = $(WMS.Document.ParseHTML(data.match(/<body[^>]*>([\s\S.]*)<\/body>/i)[0]));
			var head = data.match(/<head[^>]*>([\s\S.]*)<\/head>/i);
			$head = head != null ? $(WMS.Document.ParseHTML(head[0])) : $body;
		} else {
			$head = $body = $(WMS.Document.ParseHTML(data));
		}

		if ($body.length === 0)
			return obj;

		obj.title = $head.findAll('title').last().text();

		if (fragment) {
			var $fragment = (fragment === 'body') ? $body : $body.findAll(fragment).first();

			if ($fragment.length) {
				obj.contents = (fragment === 'body') ? $fragment : $fragment.contents();

				if (!obj.title)
					obj.title = $fragment.attr('title') || $fragment.data('title');
			}

		} else if (!fullDocument) {
			obj.contents = $body;
		}

		if (obj.contents) {
			// Clean up any <title> tags
			// Remove any parent title elements
			obj.contents = obj.contents.not(function () { return $(this).is('title') });

			// Then scrub any titles from their descendants
			obj.contents.find('title').remove();

			// Gather all script[src] elements
			obj.scripts = obj.contents.findAll('script[src]').remove();
			obj.contents = obj.contents.not(obj.scripts);
		}

		// Trim any whitespace off the title
		if (obj.title) obj.title = $.trim(obj.title);

		return obj;
	}

	WMS.Document.ExecuteScriptTags = function (scripts) {
		if (!scripts) return;

		var existingScripts = $('script[src]');

		scripts.each(function () {
			var src = this.src;
			if ((existingScripts.filter(function () { return this.src === src; })).length) return;

			var script = document.createElement('script');
			var type = $(this).attr('type');
			if (type) script.type = type;
			script.src = $(this).attr('src');
			document.head.appendChild(script);
		});
	}

	WMS.Document.ReplaceContents = function (context, container, options) {
		// TODO: Add animation options
		if ($.isFunction(options)) {
			options = { complete: options }
		}

		WMS.Document.SetTitle(container.title);
		context.stop(true).fadeOut(function () {
			if ($.isFunction(options.beforeReplace)) options.beforeReplace();

			context.html(container.contents).fadeIn(function () {
				if ($.isFunction(options.complete)) options.complete();
			});

			if ($.isFunction(options.afterReplace)) options.afterReplace();
		});
	}

	WMS.Document.CloneContents = function (container) {
		var cloned = container.clone();
		// Unmark script tags as already being eval'd so they can get executed again
		// when restored from cache. HAXX: Uses jQuery internal method.
		cloned.find('script').each(function () {
			if (!this.src) $._data(this, 'globalEval', false);
		});
		return cloned.contents();
	}

	return WMS.Document;
});
(function (addon) {
	if (!window.WMS)
		throw new Error('Requires WMS Core');
	else
		addon(window.WMS, window.WMS.$);
})(function (WMS, $) {

	'use strict';

	WMS.UI = {};

	WMS.UI.LoadingSpinner = (function () {
		var loadingSpinner = {};
		var queue = 0;
		var disable = false;

		loadingSpinner.$spinner = null;
		loadingSpinner.Init = function (selector) {
			loadingSpinner.$spinner = $(selector);
		}
		loadingSpinner.Show = function () {
			if (queue <= 0 && !disable)
				loadingSpinner.$spinner.stop(true).fadeIn();
			queue++;
		}
		loadingSpinner.Hide = function () {
			queue--;
			if (queue <= 0 && !disable)
				loadingSpinner.$spinner.stop(true).fadeOut();
		}
		loadingSpinner.Disable = function () {
			loadingSpinner.$spinner.stop(true).hide();
			disable = true;
		}
		loadingSpinner.Enable = function () {
			if (queue > 0)
				loadingSpinner.$spinner.stop(true).show();
			disable = false;
		}

		return loadingSpinner;

	})();

	WMS.UI.$notify = (function () {
		var containers = {},
			messages = {},

			notify = function (options) {

				if ($.type(options) == 'string') {
					options = { message: options };
				}

				if (arguments[1]) {
					options = $.extend(options, $.type(arguments[1]) == 'string' ? { status: arguments[1] } : arguments[1]);
				}

				return (new Message(options)).show();
			},
			closeAll = function (group, instantly) {

				var id;

				if (group) {
					for (id in messages) { if (group === messages[id].group) messages[id].close(instantly); }
				} else {
					for (id in messages) { messages[id].close(instantly); }
				}
			};

		var Message = function (options) {

			this.options = $.extend({}, Message.defaults, options);

			this.uuid = WMS.Utils.StrUId('notifymsg');
			this.element = $([

				'<div class="ui-notify-message">',
				'<a class="ui-close"></a>',
				'<div></div>',
				'</div>'

			].join('')).data("notifyMessage", this);

			this.content(this.options.message);

			// status
			if (this.options.status) {
				this.element.addClass('alert-' + this.options.status);
				this.currentstatus = this.options.status;
			}

			this.group = this.options.group;

			messages[this.uuid] = this;

			if (!containers[this.options.pos]) {
				containers[this.options.pos] = $('<div class="ui-notify ui-notify-' + this.options.pos + '"></div>').appendTo('body').on("click", ".ui-notify-message", function () {

					var message = $(this).data('notifyMessage');

					message.element.trigger('manualclose.ui.notify', [message]);
					message.close();
				});
			}
		};


		$.extend(Message.prototype, {

			uuid: false,
			element: false,
			timout: false,
			currentstatus: "",
			group: false,

			show: function () {

				if (this.element.is(':visible')) return;

				var $this = this;

				containers[this.options.pos].show().prepend(this.element);

				var marginbottom = parseInt(this.element.css('margin-bottom'), 10);

				this.element.css({ opacity: 0, marginTop: -1 * this.element.outerHeight(), marginBottom: 0 }).animate({ opacity: 1, marginTop: 0, marginBottom: marginbottom }, function () {

					if ($this.options.timeout) {

						var closefn = function () { $this.close(); };

						$this.timeout = setTimeout(closefn, $this.options.timeout);

						$this.element.hover(
							function () { clearTimeout($this.timeout); },
							function () { $this.timeout = setTimeout(closefn, $this.options.timeout); }
						);
					}

				});

				return this;
			},

			close: function (instantly) {

				var $this = this,
					finalize = function () {
						$this.element.remove();

						if (!containers[$this.options.pos].children().length) {
							containers[$this.options.pos].hide();
						}

						$this.options.onClose.apply($this, []);
						$this.element.trigger('close.ui.notify', [$this]);

						delete messages[$this.uuid];
					};

				if (this.timeout) clearTimeout(this.timeout);

				if (instantly) {
					finalize();
				} else {
					this.element.animate({ opacity: 0, marginTop: -1 * this.element.outerHeight(), marginBottom: 0 }, function () {
						finalize();
					});
				}
			},

			content: function (html) {

				var container = this.element.find(">div");

				if (!html) {
					return container.html();
				}

				container.html(html);

				return this;
			},

			status: function (status) {

				if (!status) {
					return this.currentstatus;
				}

				this.element.removeClass('alert-' + this.currentstatus).addClass('alert-' + status);

				this.currentstatus = status;

				return this;
			}
		});

		Message.defaults = {
			message: "",
			status: "",
			timeout: 5000,
			group: null,
			pos: 'top-center',
			onClose: function () { }
		};

		notify.message = Message;
		notify.closeAll = closeAll;

		return notify;
	})();

	WMS.UI.Notify = function (message, options) {
		if ($.isString(message))
			message = { message: message };

		options = $.extend({}, message, (($.isDefined(options)) ? (($.isString(options) || $.isNumeric(options)) ? { status: options } : options) : {}));

		var defaults = {
			message: "",
			status: "info",
			icon: true,
			timeout: 5000,
			pos: 'bottom-left',
			onClose: $.noop
		};

		options = $.extend({}, defaults, options);

		if ($.isNumeric(options.status)) {
			if (options.status <= 0)
				options.status = 'danger';
			else
				switch (options.status) {
					case 1:
						options.status = 'success';
						break;
					case 3:
						options.status = 'warning';
						break;
					default:
						options.status = 'info';
				}
		}

		if (options.icon) {
			if (!$.isString(options.icon)) {
				switch (options.status) {
					case 'success':
						options.icon = 'check-circle';
						break;
					case 'info':
						options.icon = 'info-circle';
						break;
					case 'warning':
						options.icon = 'exclamation-circle';
						break;
					case 'danger':
						options.icon = 'times-circle';
						break;
				}
			}

			options.message = "<i class=\"fa fa-" + options.icon + "\"></i> " + options.message;
		}

		WMS.UI.$notify(options);
	}

	return WMS.UI;
});
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
(function (addon) {
	if (!window.WMS)
		throw new Error('Requires WMS Core');
	else
		addon(window.WMS, window.WMS.$);
})(function (WMS, $) {

	'use strict';

	WMS.User = {};
	WMS.User.CheckLogin = function (success, goHome) {
		WMS.Ajax.Action('/Auth', 'CheckSignedIn', {
			notify: false,
			success: function (respond) {
				WMS.User.IsSignedIn = respond.IsSignedIn;
				WMS.User.NavItems = respond.NavItems;
				WMS.User.Data = respond.User;

				var navItems = "";
				var userName = "";
				if (WMS.User.IsSignedIn) {
					WMS.User.NavItems.forEach(function (item) {
						navItems += '<li><a href="' + item.link + '">' + item.label + '</a></li>'
					});
					$(WMS.Ajax.Page.Settings.logo).attr('href', '/');
					userName = WMS.User.Data.userName;
					if (goHome)
						WMS.Ajax.Page.Load('/', null, null, true);
					else
						WMS.Ajax.Page.Load();
				} else {
					$(WMS.Ajax.Page.Settings.logo).attr('href', 'javascript:void(0)');
					if (goHome) {
						WMS.Ajax.State = null;
						window.history.pushState(null, "", "/");
					}
					WMS.Ajax.Page.Load('/Auth/Login');
				}

				var showNav, fadeNav;
				if (WMS.Window.isSmall)
					showNav = $(WMS.Ajax.Page.Settings.navbarTop), fadeNav = $(WMS.Ajax.Page.Settings.navbarTopToggle);
				else
					showNav = $(WMS.Ajax.Page.Settings.navbarTopToggle), fadeNav = $(WMS.Ajax.Page.Settings.navbarTop);

				fadeNav.fadeOut({
					complete: function () {
						$(WMS.Ajax.Page.Settings.navbarTopLeft).html(navItems);
						$(WMS.Ajax.Page.Settings.navbarUserName).text(userName);
						if (WMS.User.IsSignedIn) {
							fadeNav.fadeIn({
								start: function () {
									showNav.show();
									WMS.Window.Resize();
									WMS.UI.LoadingSpinner.Enable();
								}
							});
						}
					},
					done: function () {
						WMS.Window.Resize();
						if (WMS.User.IsSignedIn)
							WMS.UI.LoadingSpinner.Disable();
					}
				});

				if ($.isFunction(success)) success(respond);
			}
		});
	}
	WMS.User.Signout = function () {
		bootbox.confirm({
			title: "<i class=\"fa fa-sign-out\"></i> Sign out",
			message: "Are you sure that you want to sign out?",
			buttons: {
				confirm: {
					label: "<i class=\"fa fa-sign-out\"></i> Sign out",
				}
			},
			callback: function (result) {
				if (result) {
					WMS.Ajax.Action('/Auth', 'Logout', {
						success: function () {
							$.ajax('/?_storeXsrfToken=1', {
								success: function (rsp) {
									WMS.User.CheckLogin(null, true);
								}
							});
						},
						error: WMS.User.CheckLogin
					});
				}
			}
		});
	}
	WMS.User.Init = function () {
		WMS.$window.on("load", function () {
			$(WMS.Ajax.Page.Settings.navigationTop).find('a[data-action]').click(function (e) {
				e.preventDefault();
				if ($(this).data('action') == "signout") {
					WMS.User.Signout();
				}
			});

			WMS.User.CheckLogin();
		});
	}


	return WMS.User;
});
(function(addon) {
	if (!window.WMS)
		throw new Error('Requires WMS Core');
	else
		addon(window.WMS, window.WMS.$);
})(function(WMS, $) {

	'use strict';

	WMS.Init = function() {
		$.validator.setDefaults({
			errorElement: "span",
			errorClass: "help-block",
			highlight: function(element, errorClass, validClass) {
				$(element).closest('.form-group').addClass('has-error');
			},
			unhighlight: function(element, errorClass, validClass) {
				$(element).closest('.form-group').removeClass('has-error');
			},
			errorPlacement: function(error, element) {
				if (element.parent('.input-group').length || element.prop('type') === 'checkbox' || element.prop('type') === 'radio') {
					error.insertAfter(element.parent());
				} else {
					error.insertAfter(element);
				}
			}
		});

		$.fn.dataTable.defaults.bAutoWidth = false;
		$.fn.dataTable.defaults.column.mRender = $.fn.dataTable.render.text();
		$.fn.dataTable.render.date = function() {
			return function(data, type) {
				data = data.replace(/T.*/, '');
				var dateSplit = data.split('-');
				return type === "display" || type === "filter" ?
					dateSplit[2] + '/' + dateSplit[1] + '/' + dateSplit[0] :
					data;
			}
		}
		WMS.Ajax.Init();
		WMS.Ajax.Page.Init();
		WMS.User.Init();
	}

	return WMS;
});