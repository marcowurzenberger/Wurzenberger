using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace UI_Versandhaus.Controllers
{
    public class HomeController : Controller
    {

        [HttpGet]
        public ActionResult Index()
        {
            Debug.WriteLine("Index - Get".ToUpper());

            if (Globals.IstTestSystem)
            {
                
            }

            return View();
        }
    }
}