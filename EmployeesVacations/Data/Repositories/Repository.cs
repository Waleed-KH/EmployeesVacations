using System;
using System.Linq;
using System.Reflection;
using System.Collections;
using System.Linq.Expressions;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace EmployeesVacations.Data.Repositories
{
	public abstract class Repository<TEntity> : Repository<TEntity, int>, IRepository<TEntity>
		where TEntity : class
	{
		public Repository(AppDbContext context) : base(context)
		{
		}
	}
	public abstract class Repository<TEntity, TKey> : IRepository<TEntity, TKey>
		where TEntity : class
		where TKey : IEquatable<TKey>
	{
		protected AppDbContext Context { get; }
		protected DbSet<TEntity> Entity { get; }
		public Repository(AppDbContext context)
		{
			Context = context;
			Entity = context.Set<TEntity>();
		}

		public virtual IEnumerable<TEntity> GetAll()
		{
			return Entity.AsEnumerable();
		}
		public virtual TEntity Get(TKey id)
		{
			return Entity.SingleOrDefault(KeyPredicate(id));
		}
		public virtual void Add(TEntity data)
		{
			if (data == null)
				throw new ArgumentNullException("entity");

			Entity.Add(data);
			SaveChanges();
		}
		public virtual void Update(TEntity data)
		{
			if (data == null)
				throw new ArgumentNullException("entity");

			Entity.Update(data);
			SaveChanges();
		}
		public virtual void Delete(TEntity data)
		{
			if (data == null)
				throw new ArgumentNullException("entity");

			Entity.Remove(data);
			SaveChanges();
		}
		public virtual void Delete(TKey id)
		{
			Context.Entry(KeyInstance(id)).State = EntityState.Deleted;
			SaveChanges();
		}

		protected virtual void SaveChanges()
		{
			Context.SaveChanges();
		}

		protected abstract TEntity KeyInstance(TKey id);
		protected abstract Expression<Func<TEntity, bool>> KeyPredicate(TKey id);

		Type IQueryable.ElementType => ((IQueryable)Entity).ElementType;
		Expression IQueryable.Expression => ((IQueryable)Entity).Expression;
		IQueryProvider IQueryable.Provider => ((IQueryable)Entity).Provider;
		IEnumerator<TEntity> IEnumerable<TEntity>.GetEnumerator()
		{
			return ((IEnumerable<TEntity>)Entity).GetEnumerator();
		}
		IEnumerator IEnumerable.GetEnumerator()
		{
			return ((IEnumerable)Entity).GetEnumerator();
		}
	}
}
