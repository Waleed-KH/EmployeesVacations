using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EmployeesVacations.Utilities
{
	public class ViewRequestAttribute : HttpQueryAttribute
	{
		public ViewRequestAttribute()
			: this((string)null)
		{
		}
		public ViewRequestAttribute(string viewValue)
			: this(viewValue, "")
		{
		}
		public ViewRequestAttribute(IEnumerable<string> httpMethods)
			: this(null, httpMethods)
		{
		}
		public ViewRequestAttribute(string viewValue, IEnumerable<string> httpMethods)
			: this(viewValue, httpMethods, "")
		{
		}
		public ViewRequestAttribute(string viewValue, string template)
			: this(viewValue, new string[] { "POST", "GET" }, template)
		{
		}
		public ViewRequestAttribute(string viewValue, IEnumerable<string> httpMethods, string template)
			: base("view", viewValue, httpMethods, template)
		{
		}
	}
}
