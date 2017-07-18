using EmployeesVacations.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EmployeesVacations.ViewModels
{
	public class VacationViewModel
	{
		public Employee Employee { get; set; }
		public Vacation Vacation { get; set; }
	}
}
