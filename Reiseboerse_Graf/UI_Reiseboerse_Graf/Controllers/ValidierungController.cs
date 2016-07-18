using BL_Reiseboerse_Graf;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace UI_Reiseboerse_Graf.Controllers
{
    public class ValidierungController : Controller
    {
        /// <summary>
        /// Überprüfe in der DB ob email schon registriert ist.
        /// https://msdn.microsoft.com/en-us/library/gg508808(v=vs.98).aspx?cs-save-lang=1&cs-lang=csharp#code-snippet-2
        /// 
        /// </summary>
        /// <param name="Username"></param>
        /// <returns></returns>
        //public ActionResult EmailFrei(string Username)
        //{

        //    if (testdbEntities.EmailExist(Username))
        //        return true;
        //}


        public JsonResult EmailFrei(string email)
        {
            bool benutzerExistiert = false;

            /// gehe in die BL und prüfe ob 
            /// die Email bereits vergeben ist

            if (!benutzerExistiert)
                return Json(true, JsonRequestBehavior.AllowGet);
            else
                return Json(false, JsonRequestBehavior.AllowGet);
        } 

    }

}