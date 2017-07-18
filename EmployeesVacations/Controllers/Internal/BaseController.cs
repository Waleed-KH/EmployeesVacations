using System;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;

namespace EmployeesVacations.Controllers.Internal
{
	[Route("[controller]")]
	[Route("[controller]/[action]")]
	[Authorize]
	[AutoValidateAntiforgeryToken]
	public abstract class BaseController : Controller
	{
	}
}
