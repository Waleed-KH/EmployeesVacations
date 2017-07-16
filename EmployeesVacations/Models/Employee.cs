using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace EmployeesVacations.Models
{
	public class Employee
	{
		public int EmployeeId { get; set; }
		[Required]
		public string Name { get; set; }
		[Required]
		public Gender Gender { get; set; }
		[Required]
		public DateTime Birthdate { get; set; }
		public string Email { get; set; }
		public string Address { get; set; }
		public ICollection<Vacation> Vacations { get; set; }
	}
}
