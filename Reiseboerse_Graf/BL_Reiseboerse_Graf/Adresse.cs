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
    
    public partial class Adresse
    {
        public Adresse()
        {
            this.Benutzer = new HashSet<Benutzer>();
        }
    
        public int id { get; set; }
        public string adresse1 { get; set; }
        public Nullable<System.DateTime> erstelldatum { get; set; }
    
        public virtual Land Land { get; set; }
        public virtual ICollection<Benutzer> Benutzer { get; set; }
    }
}
