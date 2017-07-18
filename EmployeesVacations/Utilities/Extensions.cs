using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using DataTables.AspNet.Core;

namespace EmployeesVacations.Utilities
{
	public static class Extensions
	{
		public static IQueryable<T> OrderBy<T>(this IQueryable<T> source, IEnumerable<IColumn> sortModels)
		{
			var expression = source.Expression;
			int count = 0;
			foreach (var item in sortModels)
			{
				var parameter = Expression.Parameter(typeof(T), "x");
				var selector = Expression.PropertyOrField(parameter, item.Field);
				var method = item.Sort.Direction == SortDirection.Descending ?
					(count == 0 ? "OrderByDescending" : "ThenByDescending") :
					(count == 0 ? "OrderBy" : "ThenBy");
				expression = Expression.Call(typeof(Queryable), method,
					new Type[] { source.ElementType, selector.Type },
					expression, Expression.Quote(Expression.Lambda(selector, parameter)));
				count++;
			}
			return count > 0 ? source.Provider.CreateQuery<T>(expression) : source;
		}
		public static bool Between(this DateTime date, DateTime min, DateTime max)
		{
			return (date >= min && date <= max);
		}
	}
}
