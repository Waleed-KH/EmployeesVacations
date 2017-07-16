using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EmployeesVacations.Utilities
{
	public static class HttpRequestExtensions
	{
		public static bool IsAjax(this HttpRequest request)
		{
			if (request.Headers != null)
				return request.Headers["X-Requested-With"] == "XMLHttpRequest";
			return false;
		}
	}
}
