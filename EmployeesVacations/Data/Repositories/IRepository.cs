using System;
using System.Linq;
using System.Collections;
using System.Collections.Generic;

namespace EmployeesVacations.Data.Repositories
{
	public interface IRepository<TEntity> : IRepository<TEntity, int>
		where TEntity : class
	{

	}
	public interface IRepository<TEntity, TKey> : IQueryable<TEntity>, IEnumerable<TEntity>, IEnumerable, IQueryable
		where TEntity : class
		where TKey : IEquatable<TKey>

	{
		IEnumerable<TEntity> GetAll();
		TEntity Get(TKey id);
		void Add(TEntity data);
		void Update(TEntity id);
		void Delete(TEntity id);
		void Delete(TKey id);
	}
}
