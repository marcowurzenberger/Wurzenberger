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
    
    public partial class Mitarbeiter
    {
        public int id { get; set; }
        public int svnr { get; set; }
        public Nullable<System.DateTime> erstelldatum { get; set; }
    
        public virtual Benutzer Benutzer { get; set; }
    }
}
