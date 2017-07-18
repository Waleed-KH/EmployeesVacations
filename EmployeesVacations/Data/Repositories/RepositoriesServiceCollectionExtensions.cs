using System;
using Microsoft.Extensions.DependencyInjection;
using EmployeesVacations.Models;

namespace EmployeesVacations.Data.Repositories
{
	public static class RepositoriesServiceCollectionExtensions
	{
		public static IServiceCollection AddAppRepositories(this IServiceCollection services)
		{
			services.AddScoped<IRepository<Employee>, EmployeesRepository>();
			services.AddScoped<IRepository<Vacation>, VacationsRepository>();
			services.AddScoped<AppRepositories>();
			return services;
		}
	}
}
