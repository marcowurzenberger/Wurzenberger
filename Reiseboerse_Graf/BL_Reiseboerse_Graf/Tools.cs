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
        /// Diese Tools wurden zur besseren Aufteilung der Methoden erstellt um
        /// z.B. Methoden anzulegen

        /// Diese Methode vergleicht das übergebene Passwort und Email mit den
        /// in der DB existierenden Benutzerdaten
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
    }
}
