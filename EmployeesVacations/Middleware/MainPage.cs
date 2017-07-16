using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using EmployeesVacations.Utilities;
using Microsoft.AspNetCore.Antiforgery;

namespace EmployeesVacations.Middleware
{
	public class MainPage
	{
		private readonly RequestDelegate _next;

		public MainPage(RequestDelegate next)
		{
			_next = next;
		}

		public Task Invoke(HttpContext httpContext, IAntiforgery antiforgery)
		{
			if (!httpContext.Request.IsAjax())
			{
				antiforgery.StoreTokensInCookie(httpContext);
				return httpContext.Response.View("MainPage");
			}
			else if (httpContext.Request.Query["_storeXsrfToken"] == "1")
			{
				antiforgery.StoreTokensInCookie(httpContext);
				return httpContext.Response.WriteAsync("1");
			}

			return _next(httpContext);
		}
	}

	public static class MainPageExtensions
	{
		public static IApplicationBuilder UseMainPage(this IApplicationBuilder builder)
		{
			return builder.UseMiddleware<MainPage>();
		}
	}

	public static class AntiforgeryExtensions
	{
		public static void StoreTokensInCookie(this IAntiforgery antiforgery, HttpContext httpContext)
		{
			httpContext.Response.Cookies.Append("XSRF-TOKEN", antiforgery.GetAndStoreTokens(httpContext).RequestToken,
				new CookieOptions() { HttpOnly = false });
		}
	}
}
