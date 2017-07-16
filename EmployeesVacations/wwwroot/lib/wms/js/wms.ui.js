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