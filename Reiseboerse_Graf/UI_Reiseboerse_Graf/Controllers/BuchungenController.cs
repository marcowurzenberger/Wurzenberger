using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UI_Reiseboerse_Graf.Models;

namespace UI_Reiseboerse_Graf.Controllers
{
    public class BuchungenController : Controller
    {
        // GET: Buchungen
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Lädt alle Buchungen aus der Datenbank zu einer bestimmten Reise
        /// </summary>
        /// <param name="reise_id"></param>
        /// <returns></returns>
        public ActionResult LadeAlleBuchungen(int reise_id)
        {

            return View();
        }



        /// <summary>
        /// Fügt eine Buchung hinzu
        /// </summary>
        /// <returns>den View zum Eingeben der Daten</returns>
        [HttpGet]
        public ActionResult Hinzufuegen()
        {
            return View();
        }

        /// <summary>
        /// Fügt eine Buchung hinzu anhand des übergebenen Models
        /// </summary>
        /// <returns></returns>
        /// 
        [HttpPost]
        public ActionResult Hinzufuegen(BuchungenModel neueBuchung)
        {
            bool angemeldet = false;
            BuchungenModel bm = new BuchungenModel();
            if (angemeldet)
            {
                return View(bm);
            }
            // falls nicht angemeldet weiterleitung zum login
            else
            {
                return RedirectToAction("Laden", "Login");
            }
            
        }
    }
}