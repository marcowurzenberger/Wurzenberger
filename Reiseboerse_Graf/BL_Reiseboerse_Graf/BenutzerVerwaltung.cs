using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace BL_Reiseboerse_Graf
{
    public class BenutzerVerwaltung
    {
        /// <summary>
        /// Überprüft ob Anmeldedaten ok sind
        /// </summary>
        /// <param name="benutzerName">Die vergebene Email-Adresse</param>
        /// <param name="passwort">Das vergebene Passwort</param>
        /// <returns>true or false</returns>
        public static bool Anmelden(string benutzerName, string passwort)
        {
           return Tools.PasswortUndEmailVergleich(benutzerName, passwort);
        }

        /// <summary>
        /// Liefert alle Kunden aus der DB
        /// </summary>
        /// <returns>Liste aller Kunden</returns>
        public static List<Kunde> AlleKunden()
        {
            reisebueroEntities context = new reisebueroEntities();

            List<Kunde> kundenListe = context.Kunde.ToList();

            return kundenListe;
        }
        
        /// <summary>
        /// Liefert alle Laender aus der DB
        /// </summary>
        /// <returns>Liste alle Laender</returns>
        public static List<Land> AlleLaender()
        {
            reisebueroEntities context = new reisebueroEntities();

            List<Land> alleLaender = context.Land.ToList();

            return alleLaender;
        }

        /// <summary>
        /// Speichert Änderungen in der DB
        /// </summary>
        /// <param name="context">Die DB-Verbindung</param>
        public static void Speichern(reisebueroEntities context)
        {
            context.SaveChanges();
        }
    }
}
