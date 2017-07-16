using EmployeesVacations.Models;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EmployeesVacations.Data
{
	public class AppDbContext : IdentityDbContext
	{
		public DbSet<Employee> Employees { get; set; }
		public DbSet<Vacation> Vacations { get; set; }
		public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
		{ }
		public AppDbContext() : base()
		{ }
		protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
		{
			optionsBuilder.UseMySql(@"Server=localhost;User Id=root;Password=asdzxc;Database=employees_vacations");
			optionsBuilder.UseQueryTrackingBehavior(QueryTrackingBehavior.TrackAll);
		}

		protected override void OnModelCreating(ModelBuilder modelBuilder)
		{
			base.OnModelCreating(modelBuilder);
			modelBuilder.Entity<Vacation>()
				.HasOne(p => p.Employee)
				.WithMany(b => b.Vacations)
				.HasForeignKey(p => p.EmployeeId);
		}
	}
}
