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