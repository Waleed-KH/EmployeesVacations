﻿using System;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using EmployeesVacations.Utilities;
using EmployeesVacations.ViewModels;
using EmployeesVacations.Controllers.Internal;
using EmployeesVacations.Data.Repositories;
using EmployeesVacations.Models;

namespace EmployeesVacations.Controllers
{
	public class EmployeesController : BaseController
	{
		private IRepository<Employee> _employeeRepository;
		public EmployeesController(IRepository<Employee> employeeRepository)
		{
			_employeeRepository = employeeRepository;
		}

		public IActionResult Index()
		{
			return View();
		}

		[ActionRequest]
		public IActionResult Get()
		{
			return Ok(new
			{
				Data = _employeeRepository.Select(a => new EmployeeViewModel()
				{
					EmployeeId = a.EmployeeId,
					Name = a.Name,
					Gender = a.Gender,
					Birthdate = a.Birthdate,
					Email = a.Email,
					Address = a.Address,
					VacationsCount = a.Vacations.Count()
				}).ToList()
			});
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