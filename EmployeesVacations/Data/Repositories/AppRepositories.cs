using EmployeesVacations.Models;
using System;

namespace EmployeesVacations.Data.Repositories
{
	public class AppRepositories
	{
		public IRepository<Employee> Employees { get; }
		public IRepository<Vacation> Vacations { get; }
		public AppRepositories(IRepository<Employee> employees, IRepository<Vacation> vacations)
		{
			Employees = employees;
			Vacations = vacations;
		}
	}
}
