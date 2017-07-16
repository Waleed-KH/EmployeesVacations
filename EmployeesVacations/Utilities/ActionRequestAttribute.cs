using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EmployeesVacations.Utilities
{
	public class ActionRequestAttribute : HttpQueryAttribute
	{
		public ActionRequestAttribute()
			: this((string)null)
		{
		}
		public ActionRequestAttribute(string actionValue)
			: this(actionValue, "")
		{
		}
		public ActionRequestAttribute(IEnumerable<string> httpMethods)
			: this(null, httpMethods)
		{
		}
		public ActionRequestAttribute(string actionValue, IEnumerable<string> httpMethods)
			: this(actionValue, httpMethods, "")
		{
		}
		public ActionRequestAttribute(string actionValue, string template)
			: this(actionValue, new string[] { "POST" }, template)
		{
		}
		public ActionRequestAttribute(string actionValue, IEnumerable<string> httpMethods, string template)
			: base("action", actionValue, httpMethods, template)
		{
		}
	}
}
