using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EmployeesVacations.Auth;
using EmployeesVacations.Utilities;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using System.Dynamic;
using Microsoft.AspNetCore.Mvc;
using EmployeesVacations.ViewModels;
using Microsoft.AspNetCore.Authorization;

namespace EmployeesVacations.Controllers
{
	public class AuthController : BaseController
	{
		private readonly UserManager<IdentityUser> _userManager;

		public AuthController(SignInManager signInManager, UserManager<IdentityUser> userManager) : base(signInManager)
		{
			_userManager = userManager;
		}

		[ActionRequest()]
		[AllowAnonymous]
		public IActionResult CheckSignedIn()
		{
			dynamic data = new ExpandoObject();
			data.IsSignedIn = SignInManager.IsSignedIn;
			if (data.IsSignedIn)
				data.User = SignInManager.CurrentUser;
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

				var result = await SignInManager.PasswordSignInAsync(user, loginData.Password, false, false);
				if (result.Succeeded)
					return Ok(new { Result = 1, Msg = "Welcome " + user.UserName + ", We hope you are in better health.", User = user });
			}

			return Ok(failData);
		}

		[ActionRequest()]
		public async Task<IActionResult> Logout()
		{
			await SignInManager.SignOutAsync();
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
