using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Abstractions;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.AspNetCore.Mvc.ViewFeatures;
using Microsoft.AspNetCore.Routing;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EmployeesVacations.Utilities
{
	public static class HttpResponseExtensions
	{
		public static Task View(this HttpResponse response, string viewName)
		{
			return response.View(viewName, null, null);
		}
		public static Task View(this HttpResponse response, string viewName, object model)
		{
			return response.View(viewName, model, null);
		}
		public static Task View(this HttpResponse response, string viewName, IDictionary<string, object> viewData)
		{
			return response.View(viewName, null, viewData);
		}
		public static Task View(this HttpResponse response, string viewName, object model, IDictionary<string, object> viewData)
		{
			var viewDataDictionary = new ViewDataDictionary(new EmptyModelMetadataProvider(), new ModelStateDictionary());
			if (viewData != null)
				foreach (var vl in viewData)
					viewDataDictionary.Add(vl);

			return response.View(viewName, model, viewDataDictionary);
		}
		internal static Task View(this HttpResponse response, string viewName, object model, ViewDataDictionary viewData)
		{
			if (model != null)
				viewData.Model = model;
			var viewResult = new ViewResult()
			{
				ViewName = viewName,
				ViewData = viewData
			};
			return viewResult.ExecuteResultAsync(new ActionContext(response.HttpContext, new RouteData(), new ActionDescriptor()));
		}
	}
}
