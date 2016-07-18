using System.Web;
using System.Web.Mvc;

namespace UI_Reiseboerse_Graf
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
