using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UI_Reiseboerse_Graf.Models;
using BL_Reiseboerse_Graf;
using System.Diagnostics;
using System.Web.Security;

namespace UI_Reiseboerse_Graf.Controllers
{
    public class BenutzerController : Controller
    {
        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public ActionResult GebuchteReisen()
        {
            return View();
        }
        [ChildActionOnly]
        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(LoginModel lm)
        {
            reisebueroEntities daten = new reisebueroEntities();
            Benutzer user = new Benutzer();
            user = daten.Benutzer.Where(x => x.email == lm.Email).FirstOrDefault();
            string pw = GetPasswort(user.passwort);


            if (lm.Email == user.email && lm.Passwort == pw)
            {
                if (lm.AngemeldetBleiben)
                {
                    FormsAuthentication.SetAuthCookie(lm.Email, true);
                }
                else
                {
                    FormsAuthentication.SetAuthCookie(lm.Email, false);
                }
            }

            return RedirectToAction("Laden", "Reisen");
        }
        [Authorize]
        [HttpGet]
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();

            return RedirectToAction("Index", "Home");
        }

        [HttpPost]
        public ActionResult BenutzerAnlegen(KundenAnlegenModel bm)
        {

            //Benutzer neuerBenutzer = new Benutzer();
            //neuerBenutzer.Id = bm.ID;
            //neuerBenutzer.Vorname = bm.Vorname;
            //neuerBenutzer.Nachname = bm.Nachname;
            //neuerBenutzer.Passwort = bm.Passwort;
            //neuerBenutzer.Geschlecht = bm.Geschlecht;

            if (Globals.IST_TESTSYSTEM)
            {
                if (ModelState.IsValid)
                {
                    Debug.WriteLine("Erfolgreich");
                    return RedirectToAction("Laden", "Reisen");
                }
                else
                {
                    return View(bm);
                }
            }
            else
            {
                // benutzer in DB speichern
            }        
        }
        [HttpGet]
        public ActionResult BenutzerAnlegen()
        {
            KundenAnlegenModel modell = new KundenAnlegenModel()
            {
                Land = new List<LandModel>()

            };
            for (int i = 0; i < 3; i++)
            {
                modell.Land.Add(new LandModel()
                {
                    landName = "Land" + i,
                    land_ID = i + 1
                });
            }
            return View(modell);
        }

        [Authorize]
        [HttpGet]
        public ActionResult Aktualisieren()
        {
            KundenModel model = new KundenModel();

            if (Globals.IST_TESTSYSTEM)
            {
                List<KundenModel> kundenListe = DummyKundenAnlegen();

                model = kundenListe.Find(x => x.Email == User.Identity.Name); 
            }
            else if (User.Identity.IsAuthenticated)
            {
                reisebueroEntities daten = new reisebueroEntities();

                List<Kunde> kunden = daten.Kunde.ToList();
                //ummappen des kundenmodels
                model = kunden.Where(x => x.Benutzer.email == User.Identity.Name).FirstOrDefault();
            }

            return View(model);
        }

        [Authorize]
        [HttpPost]
        public ActionResult Aktualisieren(KundenModel model)
        {
            /// Die geänderten Daten gehen wieder verloren, da
            /// bei erneutem Aufruf der Seite die Dummydaten wieder
            /// aufgerufen werden
            if (Globals.IST_TESTSYSTEM)
            {
                List<KundenModel> kundenListe = DummyKundenAnlegen();

                foreach (KundenModel k in kundenListe)
                {
                    if (k.ID == model.ID)
                    {
                        k.Adresse = model.Adresse;
                        k.Email = model.Email;
                        k.GeburtsDatum = model.GeburtsDatum;
                        k.Geschlecht = model.Geschlecht;
                        k.Land = model.Land;
                        k.Land_ID = model.Land_ID;
                        k.Nachname = model.Nachname;
                        k.Passwort = model.Passwort;
                        k.PasswortWiederholung = model.PasswortWiederholung;
                        k.Plz = model.Plz;
                        k.Telefon = model.Telefon;
                        k.Titel = model.Titel;
                        k.Vorname = model.Vorname;
                    }
                }
            }

            return RedirectToAction("Laden", "Reisen");
        }

        private List<KundenModel> DummyKundenAnlegen()
        {
            List<KundenModel> kunden = new List<KundenModel>();

            bool geschlechtAnlegen = true;

            for (int i = 1; i <= 30; i++)
            {
                if (i % 2 == 0)
                {
                    geschlechtAnlegen = false;
                }

                kunden.Add(new KundenModel
                {
                    ID = i,
                    Email = "maxmuster@gmx" + i + ".at",
                    GeburtsDatum = new DateTime(1980 + i, 1, 1 + i),
                    Geschlecht = geschlechtAnlegen,
                    Vorname = "Maxi",
                    Nachname = "Muster",
                    Land = new List<LandModel>()
                    {
                        new LandModel { land_ID = 1, landName = "Österreich" },
                        new LandModel { land_ID = 2, landName = "Deutschland" },
                        new LandModel { land_ID = 3, landName = "Italien" },
                    },
                    Passwort = "123" + i + "user!",
                    PasswortWiederholung = "123" + i + "user!",
                    Plz = "101" + i,
                    Telefon = "067612345" + i,
                    Titel = "",
                    Adresse = "Musterstrasse 1" + i,
                    Land_ID = i + 1
                });
            }

            return kunden;
        }

        private string GetPasswort(byte[] passwort)
        {
            string pw = string.Empty;

            pw = System.Text.Encoding.UTF8.GetString(passwort);

            return pw;
        }
    }
}