using System;
using Microsoft.AspNetCore.Mvc;
using EmployeesVacations.Utilities;
using EmployeesVacations.Auth;
using EmployeesVacations.ViewModels;
using Microsoft.AspNetCore.Authorization;

namespace EmployeesVacations.Controllers
{
	[Route("")]
	[Authorize]
	public class HomeController : BaseController
	{
		public HomeController(SignInManager signInManager) : base(signInManager)
		{
		}

		[Route("")]
		public IActionResult Index()
		{
			return View(new User() { IdentityUser = SignInManager.CurrentUser });
		}
	}
}
