//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace BL_Reiseboerse_Graf
{
    using System;
    using System.Collections.Generic;
    
    public partial class Benutzer
    {
        public Benutzer()
        {
            this.Kunde = new HashSet<Kunde>();
            this.Mitarbeiter = new HashSet<Mitarbeiter>();
        }
    
        public int id { get; set; }
        public string email { get; set; }
        public byte[] passwort { get; set; }
        public string vorname { get; set; }
        public string nachname { get; set; }
        public bool geschlecht { get; set; }
        public string telefon { get; set; }
        public Nullable<System.DateTime> erstelldatum { get; set; }
    
        public virtual Adresse Adresse { get; set; }
        public virtual ICollection<Kunde> Kunde { get; set; }
        public virtual ICollection<Mitarbeiter> Mitarbeiter { get; set; }
    }
}