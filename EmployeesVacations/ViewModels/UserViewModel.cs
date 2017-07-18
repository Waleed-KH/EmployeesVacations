using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EmployeesVacations.ViewModels
{
	public class UserViewModel
	{
		public IdentityUser IdentityUser { get; set; }
	}
}
