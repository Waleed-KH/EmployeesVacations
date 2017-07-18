using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace EmployeesVacations.Models
{
	public class Vacation
	{
		public int VacationId { get; set; }
		[Required]
		public VacationType Type { get; set; }
		[Required]
		[DataType(DataType.Date)]
		public DateTime StartDate { get; set; }
		[Required]
		[DataType(DataType.Date)]
		public DateTime EndDate { get; set; }
		public int Duration
		{
			get
			{
				return (EndDate - StartDate).Days;
			}
		}
		public int EmployeeId { get; set; }
		public Employee Employee { get; set; }

	}
}
