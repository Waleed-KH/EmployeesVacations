﻿(function (addon) {
	if (!window.WMS)
		throw new Error('Requires WMS Core');
	else
		addon(window.WMS, window.WMS.$);
})(function (WMS, $) {

	'use strict';

	WMS.Init = function () {
		$.validator.setDefaults({
			errorElement: "span",
			errorClass: "help-block",
			highlight: function (element, errorClass, validClass) {
				$(element).closest('.form-group').addClass('has-error');
			},
			unhighlight: function (element, errorClass, validClass) {
				$(element).closest('.form-group').removeClass('has-error');
			},
			errorPlacement: function (error, element) {
				if (element.parent('.input-group').length || element.prop('type') === 'checkbox' || element.prop('type') === 'radio') {
					error.insertAfter(element.parent());
				} else {
					error.insertAfter(element);
				}
			}
		});

		$.fn.dataTable.defaults.bAutoWidth = false;
		$.fn.dataTable.defaults.column.mRender = $.fn.dataTable.render.text();

		WMS.Ajax.Init();
		WMS.Ajax.Page.Init();
		WMS.User.Init();
	}

	return WMS;
});