using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using EmployeesVacations.Models;
using EmployeesVacations.Utilities;
using EmployeesVacations.Data.Repositories;
using EmployeesVacations.Controllers.Internal;
using DataTables.AspNet.Core;
using DataTables.AspNet.AspNetCore;

namespace EmployeesVacations.Controllers
{
	public class VacationsController : BaseController
	{
		private AppRepositories _repository;
		public VacationsController(AppRepositories repository)
		{
			_repository = repository;
		}

		[HttpGet]
		public IActionResult Index()
		{
			return Ok("Helllooooo");
		}

		[HttpGet("{employeeId}")]
		public IActionResult Index(int employeeId)
		{
			var employee = _repository.Employees.Get(employeeId);
			if (employee == null)
				return NotFound();

			ViewData["action"] = "edit";
			return View(new Vacation() { Employee = employee });
		}

		[ActionRequest(null, "{employeeId}")]
		public IActionResult Get(int employeeId, [FromForm] IDataTablesRequest request)
		{
			IDataTablesResponse response;
			if (ModelState.IsValid)
			{
				var data = _repository.Vacations.Where(v => v.EmployeeId == employeeId);
				IQueryable<Vacation> filteredData;
				if (!String.IsNullOrWhiteSpace(request.Search.Value))
				{
					DateTime dateFilter;
					bool searchDate = DateTime.TryParse(request.Search.Value, out dateFilter);
					filteredData = data.Where(e =>
						searchDate ? (dateFilter == e.StartDate || dateFilter == e.EndDate) : false ||
						e.Type.ToString().Contains(request.Search.Value));
				}
				else
				{
					filteredData = data;
				}

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


		[HttpGet("{employeeId}/[action]")]
		public IActionResult Add(int employeeId)
		{
			return View("Form", new Vacation() { EmployeeId = employeeId });
		}
		[HttpPost("[action]")]
		public IActionResult Add([FromForm] Vacation vacation)
		{
			if (ModelState.IsValid)
			{
				_repository.Vacations.Add(vacation);
				return Ok(new { Result = 1, Msg = "Vacation has been added successfully." });
			}

			return Ok(new { Result = 0, Msg = "Error adding vacation!", ModelState = ModelState });
		}

		[HttpGet("[action]/{id}")]
		public IActionResult Edit(int id)
		{
			var vacation = _repository.Vacations.Get(id);
			if (vacation == null)
				return NotFound();

			ViewData["action"] = "edit";
			return View("Form", vacation);
		}
		[HttpPost("[action]")]
		public IActionResult Edit([FromForm] Vacation vacation)
		{
			if (ModelState.IsValid)
			{
				_repository.Vacations.Update(vacation);
				return Ok(new { Result = 1, Msg = "Vacation has been updated successfully." });
			}

			return Ok(new { Result = 0, Msg = "Error updating vacation!", ModelState = ModelState });
		}

		[ActionRequest]
		public IActionResult Delete([FromForm] int id)
		{
			if (ModelState.IsValid)
			{
				_repository.Vacations.Delete(id);
				return Ok(new { Result = 1, Msg = "Vacation has been deleted successfully." });
			}

			return Ok(new { Result = 0, Msg = "Error deleting vacation!", ModelState = ModelState });
		}
	}
}
