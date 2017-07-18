using System;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using EmployeesVacations.Auth;

namespace EmployeesVacations.Controllers.Internal
{
	public class UserController : BaseController
	{
		protected IdentityUser CurrentUser { get; }
		public UserController(SignInManager signInManager)
		{
			if (signInManager.IsSignedIn)
				CurrentUser = signInManager.CurrentUser;
		}
	}
}
