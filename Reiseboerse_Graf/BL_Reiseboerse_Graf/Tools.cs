using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Security.Cryptography;

namespace BL_Reiseboerse_Graf
{
    public class Tools
    {
        /// <summary>
        /// Diese Methode vergleicht Email und Passwort mit den Daten in der DB
        /// </summary>
        /// <param name="email">Email-Adresse des Users</param>
        /// <param name="passwort">Passwort aus der Oberfläche</param>
        /// <returns>true oder false</returns>
        public static bool PasswortUndEmailVergleich(string email, string passwort)
        {
            reisebueroEntities context = new reisebueroEntities();

            SHA256 hash = SHA256.Create();

            byte[] pw = hash.ComputeHash(Encoding.UTF8.GetBytes(passwort));

            foreach (Benutzer b in context.Benutzer)
            {
                if (b.email == email && pw.SequenceEqual(b.passwort))
                {
                    return true;
                }
            }

            return false;
        }

        /// <summary>
        /// Diese Methode vergleicht das Passwort mit den in der DB
        /// existierenden Daten
        /// </summary>
        /// <param name="passwort">Passwort aus der Oberfläche in Klartext</param>
        /// <returns>true oder false</returns>
        public static bool PasswortVergleich(string passwort)
        {
            reisebueroEntities context = new reisebueroEntities();

            SHA256 hash = SHA256.Create();

            byte[] pw = hash.ComputeHash(Encoding.UTF8.GetBytes(passwort));

            foreach (Benutzer b in context.Benutzer)
            {
                if (b.passwort == pw)
                {
                    return true;
                }
            }

            return false;
        }

        /// <summary>
        /// Diese Methode vergleicht das Passwort und gibt es als ByteArray zurück
        /// </summary>
        /// <param name="passwort">Passwort in Klartext</param>
        /// <returns>ByteArray</returns>
        public static byte[] PasswortZuByteArray(string passwort)
        {
            reisebueroEntities context = new reisebueroEntities();

            SHA256 hash = SHA256.Create();

            byte[] pw = hash.ComputeHash(Encoding.UTF8.GetBytes(passwort));

            foreach (Benutzer b in context.Benutzer)
            {
                if (pw.SequenceEqual(b.passwort))
                {
                    return pw;
                }
            }

            return null;
        }
    }
}
