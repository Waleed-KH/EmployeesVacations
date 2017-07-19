using System;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using EmployeesVacations.Utilities;
using EmployeesVacations.ViewModels;
using EmployeesVacations.Controllers.Internal;
using EmployeesVacations.Data.Repositories;
using EmployeesVacations.Models;
using DataTables.AspNet.Core;
using DataTables.AspNet.AspNetCore;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc.ModelBinding;

namespace EmployeesVacations.Controllers
{
	public class EmployeesController : BaseController
	{
		private IRepository<Employee> _employeeRepository;
		public EmployeesController(IRepository<Employee> employeeRepository)
		{
			_employeeRepository = employeeRepository;
		}

		[HttpGet]
		public IActionResult Index()
		{
			return View();
		}

		//[ActionRequest]
		//public IActionResult Get()
		//{
		//	return Ok(new
		//	{
		//		Data = _employeeRepository.Select(a => new EmployeeViewModel()
		//		{
		//			EmployeeId = a.EmployeeId,
		//			Name = a.Name,
		//			Gender = a.Gender,
		//			Birthdate = a.Birthdate,
		//			Email = a.Email,
		//			Address = a.Address,
		//			VacationsCount = a.Vacations.Count()
		//		}).ToList()
		//	});
		//}

		[ActionRequest]
		public IActionResult Get([FromForm] IDataTablesRequest request)
		{
			IDataTablesResponse response;
			if (ModelState.IsValid)
			{
				var data = _employeeRepository.Select(a => new EmployeeViewModel()
				{
					EmployeeId = a.EmployeeId,
					Name = a.Name,
					Gender = a.Gender,
					Birthdate = a.Birthdate,
					Email = a.Email,
					Address = a.Address,
					VacationsCount = a.Vacations.Count()
				});

				var filteredData = String.IsNullOrWhiteSpace(request.Search.Value)
					? data : data.Where(e =>
						e.EmployeeId.ToString().Contains(request.Search.Value) ||
						e.Name.Contains(request.Search.Value) ||
						e.Email.Contains(request.Search.Value));

				var dataPage = filteredData.OrderBy(request.Columns.Where(x => x.Sort != null)).Skip(request.Start).Take(request.Length);

				response = DataTablesResponse.Create(request, data.Count(), filteredData.Count(), dataPage.ToList());
			}
			else
			{
				response = DataTablesResponse.Create(request, "Error getting employees data!", new Dictionary<string, object>()
				{
					{ "ModelState", ModelState }
				});
			}
			return new DataTablesJsonResult(response, true);
		}


		[HttpGet("[action]")]
		public IActionResult Add()
		{
			return View("Form");
		}
		[HttpPost("[action]")]
		public IActionResult Add([FromForm] Employee employee)
		{
			if (ModelState.IsValid)
			{
				_employeeRepository.Add(employee);
				return Ok(new { Result = 1, Msg = "Employee has been added successfully." });
			}

			return Ok(new { Result = 0, Msg = "Error adding employee!", ModelState = ModelState });
		}

		[HttpGet("[action]/{id}")]
		public IActionResult Edit(int id)
		{
			var employee = _employeeRepository.Get(id);
			if (employee == null)
				return NotFound();

			ViewData["action"] = "edit";
			return View("Form", employee);
		}
		[HttpPost("[action]")]
		public IActionResult Edit([FromForm] Employee employee)
		{
			if (ModelState.IsValid)
			{
				_employeeRepository.Update(employee);
				return Ok(new { Result = 1, Msg = "Employee has been updated successfully." });
			}

			return Ok(new { Result = 0, Msg = "Error updating employee!", ModelState = ModelState });
		}

		[ActionRequest]
		public IActionResult Delete([FromForm] int id)
		{
			if (ModelState.IsValid)
			{
				_employeeRepository.Delete(id);
				return Ok(new { Result = 1, Msg = "Employee has been deleted successfully." });
			}

			return Ok(new { Result = 0, Msg = "Error deleting employee!", ModelState = ModelState });
		}
	}
}
