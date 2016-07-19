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

            if (false)
            {
                List<KundenModel> kundenListe = DummyKundenAnlegen();

                model = kundenListe.Find(x => x.Email == User.Identity.Name); 
            }
            else
            {
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
                        model.Adresse = k.Benutzer.Adresse.plz.ToString() + " ";
                        model.Adresse += k.Benutzer.Adresse.Ort.bezeichnung + " ";
                        model.Adresse += k.Benutzer.Adresse.strasse + " ";
                        model.Adresse += k.Benutzer.Adresse.nummer;
                        model.Email = k.Benutzer.email;
                        model.GeburtsDatum = k.geburtsdatum;
                        model.Geschlecht = k.Benutzer.geschlecht;
                        model.ID = k.id;
                        model.Land_ID = k.Land.id;
                        model.Nachname = k.Benutzer.nachname;
                        model.Passwort = Tools.HashPasswortZuString(k.Benutzer.passwort);
                        model.PasswortWiederholung = Tools.HashPasswortZuString(k.Benutzer.passwort);
                        model.Telefon = k.Benutzer.telefon;
                        model.Titel = k.titel;
                        model.Vorname = k.Benutzer.vorname;
                        model.Land = lmListe;
                    }
                }
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
                List<KundenModel> kundenListe = DummyKundenAnlegen();

                if (false)
                {
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
                else
                {
                    List<Kunde> kunden = BenutzerVerwaltung.AlleKunden();

                    foreach (Kunde k in kunden)
                    {
                        if (k.id == model.ID)
                        {
                            #region AdresseSplitten
                            
                            /// Da die Adresse in der DB geteilt ist und im Model nicht,
                            /// muss diese Hier "geteilt" werden
                            string[] adressArray = null;
                            adressArray = model.Adresse.Split(' ');

                            #endregion

                            #region Land

                            /// Für jeden Kunden eine Liste von Ländern für
                            /// die Profilseite zur Verfügung stellen
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

                            k.Benutzer.Adresse.Land.id = model.Land_ID;
                            k.Benutzer.Adresse.plz = int.Parse(adressArray[0]);
                            k.Benutzer.Adresse.Ort.bezeichnung = adressArray[1];
                            k.Benutzer.Adresse.strasse = adressArray[2];
                            k.Benutzer.Adresse.nummer = adressArray[3];
                            k.Benutzer.email = model.Email;
                            k.geburtsdatum = model.GeburtsDatum;
                            k.Benutzer.geschlecht = model.Geschlecht;
                            k.Benutzer.nachname = model.Nachname;
                            k.Benutzer.vorname = model.Vorname;
                            k.Benutzer.passwort = Tools.GetHashPasswort(model.Passwort);
                            k.Benutzer.passwort = Tools.GetHashPasswort(model.PasswortWiederholung);
                            k.Benutzer.telefon = model.Telefon;
                            k.titel = model.Titel;
                            k.Land = l;
                            
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
    }
}