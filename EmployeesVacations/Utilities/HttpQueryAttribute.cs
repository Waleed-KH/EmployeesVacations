using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc.ActionConstraints;
using Microsoft.AspNetCore.Mvc.Routing;

namespace EmployeesVacations.Utilities
{
	public class HttpQueryAttribute : HttpMethodAttribute, IActionConstraint
	{
		public HttpQueryAttribute(string queryKey, string queryValue)
			: this(queryKey, queryValue, (string)null)
		{
		}

		public HttpQueryAttribute(string queryKey, string queryValue, string template)
			: this(queryKey, queryValue, new string[] { "POST", "GET" }, template)
		{
		}

		public HttpQueryAttribute(string queryKey, string queryValue, IEnumerable<string> httpMethods)
			: this(queryKey, queryValue, httpMethods, null)
		{
		}

		public HttpQueryAttribute(string queryKey, string queryValue, IEnumerable<string> httpMethods, string template)
			: base(httpMethods, template)
		{
			QueryKey = queryKey;
			QueryValue = queryValue;
		}

		private string QueryKey { get; }
		private string QueryValue { get; }

		public bool Accept(ActionConstraintContext context)
		{
			var queryVal = QueryValue;
			if (string.IsNullOrEmpty(queryVal))
				queryVal = ((dynamic)context.CurrentCandidate.Action).ActionName;
			return string.Equals(context.RouteContext.HttpContext.Request.Query[QueryKey], queryVal, StringComparison.OrdinalIgnoreCase) || string.Equals(context.RouteContext.HttpContext.Request.Form[QueryKey], queryVal, StringComparison.OrdinalIgnoreCase);
		}
	}
}
