using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using EmployeesVacations.Data;
using Microsoft.Extensions.DependencyInjection.Extensions;
using EmployeesVacations.Auth;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using EmployeesVacations.Middleware;
using Microsoft.AspNetCore.Antiforgery;
using Microsoft.AspNetCore.Http;
using EmployeesVacations.Utilities;
using EmployeesVacations.Data.Repositories;
using DataTables.AspNet.AspNetCore;

namespace EmployeesVacations
{
	public class Startup
	{
		public Startup(IHostingEnvironment env)
		{
			var builder = new ConfigurationBuilder()
				.SetBasePath(env.ContentRootPath)
				.AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
				.AddJsonFile($"appsettings.{env.EnvironmentName}.json", optional: true)
				.AddEnvironmentVariables();
			Configuration = builder.Build();
		}

		public IConfigurationRoot Configuration { get; }

		// This method gets called by the runtime. Use this method to add services to the container.
		public void ConfigureServices(IServiceCollection services)
		{
			services.AddMvc();
			services.AddAntiforgery(options =>
			{
				options.HeaderName = "X-CSRF-TOKEN";
				options.CookieName = ".AntiforgeryToken.";
			});
			services.AddDbContext<AppDbContext>();
			services.TryAddScoped<SignInManager>();
			services.AddIdentity<IdentityUser, IdentityRole>().AddEntityFrameworkStores<AppDbContext>().AddDefaultTokenProviders();
			services.AddAppRepositories();
			services.RegisterDataTables();
		}

		// This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
		public void Configure(IApplicationBuilder app, IHostingEnvironment env, ILoggerFactory loggerFactory)
		{
			loggerFactory.AddConsole(Configuration.GetSection("Logging"));
			loggerFactory.AddDebug();

			if (env.IsDevelopment())
			{
				app.UseDeveloperExceptionPage();
				app.UseBrowserLink();
			}
			else
			{
				app.UseExceptionHandler("/Home/Error");
			}

			app.UseStaticFiles();
			app.UseIdentity();
			app.UseMainPage();
			app.UseMvc();
		}
	}
}
