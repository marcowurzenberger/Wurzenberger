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
    
    public partial class Reisedetail
    {
        public int id { get; set; }
        public System.DateTime startdatum { get; set; }
        public System.DateTime enddatum { get; set; }
        public System.DateTime anmeldefrist { get; set; }
        public Nullable<System.DateTime> erstelldatum { get; set; }
    
        public virtual Buchung Buchung { get; set; }
        public virtual Reise Reise { get; set; }
    }
}
