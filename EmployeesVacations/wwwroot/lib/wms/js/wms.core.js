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