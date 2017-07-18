using System;
using System.Linq.Expressions;
using EmployeesVacations.Models;

namespace EmployeesVacations.Data.Repositories
{
	public class EmployeesRepository : Repository<Employee>
	{
		public EmployeesRepository(AppDbContext context) : base(context)
		{
		}

		protected override Employee KeyInstance(int id) => new Employee() { EmployeeId = id };
		protected override Expression<Func<Employee, bool>> KeyPredicate(int id) => e => e.EmployeeId == id;
	}
}
