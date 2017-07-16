using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace EmployeesVacations.ViewModels
{
	public class AuthLoginViewModel
	{
		[Required]
		[MinLength(4)]
		public string Username { get; set; }
		[Required]
		[MinLength(6)]
		[DataType(DataType.Password)]
		public string Password { get; set; }
	}
}
