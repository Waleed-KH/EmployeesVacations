using EmployeesVacations.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace EmployeesVacations.ViewModels
{
	public class EmployeeViewModel
	{
		[Display(Name = "Employee Id")]
		public int EmployeeId { get; set; }
		public string Name { get; set; }
		public Gender Gender { get; set; }
		public DateTime Birthdate { get; set; }
		public string Email { get; set; }
		public string Address { get; set; }
		[Display(Name = "Vacations Count")]
		public int VacationsCount { get; set; }
	}
}
