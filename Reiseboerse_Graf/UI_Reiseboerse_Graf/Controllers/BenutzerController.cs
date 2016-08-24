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
            if (BenutzerVerwaltung.Anmelden(lm.Email, lm.Passwort))
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
        public ActionResult Anlegen(KundenAnlegenModel bm)
        {
            reisebueroEntities context = new reisebueroEntities();

            List<Land> landList = new List<Land>();
            landList = BenutzerVerwaltung.AlleLaender();

            List<LandModel> lmList = new List<LandModel>();

            List<Benutzer> benutzer = new List<Benutzer>();
            benutzer = context.Benutzer.ToList();

            Benutzer neuerBenutzer = new Benutzer();
            neuerBenutzer.Adresse = new Adresse();
            Kunde neuerKunde = new Kunde();
            neuerKunde.Land = new Land();

            if (ModelState.IsValid)
            {
                neuerBenutzer.Adresse.adresse1 = bm.Adresse;
                neuerBenutzer.email = bm.Email;
                neuerBenutzer.geschlecht = bm.Geschlecht;
                neuerBenutzer.passwort = Tools.PasswortZuByteArray(bm.Passwort);
                neuerBenutzer.telefon = bm.Telefon;
                neuerBenutzer.vorname = bm.Vorname;
                neuerBenutzer.nachname = bm.Nachname;

                neuerKunde.Benutzer = neuerBenutzer;
                neuerKunde.geburtsdatum = bm.GeburtsDatum;
                neuerKunde.titel = bm.Titel;
                neuerKunde.Land.id = bm.Land_ID;

                neuerBenutzer.Kunde.Add(neuerKunde);
                benutzer.Add(neuerBenutzer);

                context.SaveChanges();

                return RedirectToAction("Laden", "Reisen");
            }
            else
            {
                /// Wenn das Model nicht valide ist, wird eine neue Landliste generiert,
                /// da dieses bei erneutem Aufruf sonst verloren geht
                foreach (Land l in landList)
                {
                    lmList.Add(new LandModel() { landName = l.bezeichnung, land_ID = l.id });
                }

                return View(bm);
            }
        }

        [HttpGet]
        public ActionResult Anlegen()
        {
            reisebueroEntities context = new reisebueroEntities();

            KundenModel km = new KundenModel();
            km.GeburtsDatum = DateTime.Now;

            List<Land> laender = BenutzerVerwaltung.AlleLaender();
            List<LandModel> landList = new List<LandModel>();

            /// Hier werden die Länder der landList hinzugefügt um
            /// die Dropdown-Liste in der View zu füllen
            foreach (Land l in laender)
            {
                landList.Add(new LandModel() { landName = l.bezeichnung, land_ID = l.id });
            }

            km.Land = landList;

            return View(km);
        }

        [Authorize]
        [HttpGet]
        public ActionResult Aktualisieren()
        {
            KundenModel model = new KundenModel();

            List<Kunde> kunden = BenutzerVerwaltung.AlleKunden();

            List<Land> laender = BenutzerVerwaltung.AlleLaender();
            List<LandModel> lmListe = new List<LandModel>();
            foreach (Land l in laender)
            {
                lmListe.Add(new LandModel() { landName = l.bezeichnung, land_ID = l.id });
            }

            //ummappen des kundenmodels
            foreach (Kunde k in kunden)
            {
                if (k.Benutzer.email == User.Identity.Name)
                {
                    model.Adresse = k.Benutzer.Adresse.adresse1;
                    model.Email = k.Benutzer.email;
                    model.GeburtsDatum = k.geburtsdatum;
                    model.Geschlecht = k.Benutzer.geschlecht;
                    model.Land_ID = k.Land.id;
                    model.Nachname = k.Benutzer.nachname;
                    model.Passwort = k.Benutzer.passwort.ToString();
                    model.PasswortWiederholung = k.Benutzer.passwort.ToString();
                    model.Telefon = k.Benutzer.telefon;
                    model.Titel = k.titel;
                    model.Vorname = k.Benutzer.vorname;
                    model.Land = lmListe;
                    model.ID = k.id;
                }
            }

            return View(model);
        }

        [Authorize]
        [HttpPost]
        public ActionResult Aktualisieren(KundenModel model)
        {
            List<Kunde> kunden = BenutzerVerwaltung.AlleKunden();

            foreach (Kunde k in kunden)
            {
                if (k.id == model.ID)
                {
                    #region Land

                    /// Das ausgewählte Land des Kunden muss wieder neu geladen werden
                    Land l = new Land();
                    foreach (LandModel lm in model.Land)
                    {
                        if (lm.land_ID == k.Land.id)
                        {
                            l.id = lm.land_ID;
                            l.bezeichnung = lm.landName;
                        }
                    }
                    #endregion

                    k.Benutzer.Adresse.adresse1 = model.Adresse;
                    k.Benutzer.email = model.Email;
                    k.Benutzer.geschlecht = model.Geschlecht;
                    k.Benutzer.nachname = model.Nachname;
                    k.Benutzer.vorname = model.Vorname;
                    k.Benutzer.passwort = Tools.PasswortZuByteArray(model.Passwort);
                    k.Benutzer.passwort = Tools.PasswortZuByteArray(model.PasswortWiederholung);
                    k.Benutzer.telefon = model.Telefon;
                    k.titel = model.Titel;
                    k.Land = l;
                    k.geburtsdatum = model.GeburtsDatum;

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
                    //Plz = "101" + i,
                    Telefon = "067612345" + i,
                    Titel = "",
                    Adresse = "Musterstrasse 1" + i,
                    Land_ID = i + 1
                });
            }

            return kunden;
        }
    }
}