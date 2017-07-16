using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;

namespace EmployeesVacations.Auth
{
	public class SignInManager : SignInManager<IdentityUser>
	{
		public new bool IsSignedIn => base.IsSignedIn(Context.User);
		public IdentityUser CurrentUser => GetCurrentUserAsync().Result;
		public SignInManager(UserManager<IdentityUser> userManager, IHttpContextAccessor contextAccessor, IUserClaimsPrincipalFactory<IdentityUser> claimsFactory, IOptions<IdentityOptions> optionsAccessor, ILogger<SignInManager<IdentityUser>> logger) : base(userManager, contextAccessor, claimsFactory, optionsAccessor, logger)
		{
		}
		public Task<IdentityUser> GetCurrentUserAsync() => UserManager.GetUserAsync(Context.User);
	}
}
