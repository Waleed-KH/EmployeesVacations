using System;

namespace EmployeesVacations.Data.Repositories
{
	public class AppRepositories
	{
		public EmployeesRepository Employees { get; }
		public VacationsRepository Vacations { get; }
		public AppRepositories(EmployeesRepository employees, VacationsRepository vacations)
		{
			Employees = employees;
			Vacations = vacations;
		}
	}
}
