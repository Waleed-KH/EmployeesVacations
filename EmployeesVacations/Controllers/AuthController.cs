using System;
using System.Dynamic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using EmployeesVacations.Auth;
using EmployeesVacations.Utilities;
using EmployeesVacations.ViewModels;
using EmployeesVacations.Controllers.Internal;

namespace EmployeesVacations.Controllers
{
	public class AuthController : UserController
	{
		private readonly UserManager<IdentityUser> _userManager;
		private readonly SignInManager _signInManager;

		public AuthController(SignInManager signInManager, UserManager<IdentityUser> userManager) : base(signInManager)
		{
			_userManager = userManager;
			_signInManager = signInManager;
		}

		[ActionRequest]
		[AllowAnonymous]
		public IActionResult CheckSignedIn()
		{
			dynamic data = new ExpandoObject();
			data.IsSignedIn = _signInManager.IsSignedIn;
			if (data.IsSignedIn)
			{
				data.User = _signInManager.CurrentUser;
				data.NavItems = new dynamic[]
				{
					new
					{
						Label = "Employees",
						Link = "/Employees"
					}
				};
			}
			return Ok(data);
		}

		[HttpGet]
		[AllowAnonymous]
		public IActionResult Login()
		{
			return View();
		}

		[HttpPost]
		[AllowAnonymous]
		public async Task<IActionResult> Login(AuthLoginViewModel loginData)
		{
			var failData = new { Result = 0, Msg = "Username or password is incorrect!" };

			if (ModelState.IsValid)
			{
				var user = await _userManager.FindByNameAsync(loginData.Username);
				if (user == null)
					return Ok(failData);

				var result = await _signInManager.PasswordSignInAsync(user, loginData.Password, false, false);
				if (result.Succeeded)
				{
					return Ok(new
					{
						Result = 1,
						Msg = "Welcome " + user.UserName + ", We hope you are in better health.",
						User = user,
					});
				}
			}

			return Ok(failData);
		}

		[ActionRequest]
		public async Task<IActionResult> Logout()
		{
			await _signInManager.SignOutAsync();
			return Ok(new { Result = 1, Msg = "You have signed out successfully." });
		}

		[HttpGet]
		[AllowAnonymous]
		public async Task<IActionResult> CreateMyAccount()
		{
			return Ok(await _userManager.CreateAsync(new IdentityUser()
			{
				Email = "waleed1kh@yahoo.com",
				UserName = "waleed"
			}, "P@ssw0rd"));
		}

	}
}
