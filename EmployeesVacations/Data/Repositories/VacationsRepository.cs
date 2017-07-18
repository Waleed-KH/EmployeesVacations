using System;
using System.Linq.Expressions;
using EmployeesVacations.Models;

namespace EmployeesVacations.Data.Repositories
{
	public class VacationsRepository : Repository<Vacation>
	{
		public VacationsRepository(AppDbContext context) : base(context)
		{
		}
		protected override Vacation KeyInstance(int id) => new Vacation() { VacationId = id };
		protected override Expression<Func<Vacation, bool>> KeyPredicate(int id) => e => e.VacationId == id;
	}
}
