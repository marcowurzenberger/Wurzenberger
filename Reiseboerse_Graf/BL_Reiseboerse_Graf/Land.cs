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
    
    public partial class Land
    {
        public Land()
        {
            this.Adresse = new HashSet<Adresse>();
            this.Kunde = new HashSet<Kunde>();
        }
    
        public int id { get; set; }
        public string bezeichnung { get; set; }
        public Nullable<System.DateTime> erstelldatum { get; set; }
    
        public virtual ICollection<Adresse> Adresse { get; set; }
        public virtual ICollection<Kunde> Kunde { get; set; }
    }
}