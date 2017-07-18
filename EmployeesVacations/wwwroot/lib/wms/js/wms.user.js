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