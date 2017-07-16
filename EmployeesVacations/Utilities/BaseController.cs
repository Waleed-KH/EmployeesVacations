using EmployeesVacations.Auth;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EmployeesVacations.Utilities
{
	[Route("[controller]")]
	[Route("[controller]/[action]")]
	[Authorize]
	[AutoValidateAntiforgeryToken]
	public abstract class BaseController : Controller
	{
		protected SignInManager SignInManager { get; }
		public BaseController(SignInManager signInManager)
		{
			SignInManager = signInManager;
		}
	}
}
