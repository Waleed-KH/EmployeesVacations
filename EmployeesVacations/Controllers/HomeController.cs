using System;
using Microsoft.AspNetCore.Mvc;
using EmployeesVacations.Utilities;
using EmployeesVacations.Auth;
using EmployeesVacations.ViewModels;
using Microsoft.AspNetCore.Authorization;
using EmployeesVacations.Data;
using EmployeesVacations.Controllers.Internal;

namespace EmployeesVacations.Controllers
{
	[Route("")]
	public class HomeController : UserController
	{
		public HomeController(SignInManager signInManager) : base(signInManager)
		{
		}

		public IActionResult Index()
		{
			return View(new UserViewModel() { IdentityUser = CurrentUser });
		}
	}
}
