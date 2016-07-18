using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UI_Reiseboerse_Graf.Models
{
    public class UnterkunftdetailModel
    {
        public int ID { get; set; }
        public string Bezeichnung { get; set; }
        public int Verpflegung_ID { get; set; }
        public VerpflegungModel Verpflegung { get; set; }
        public string Beschreibung { get; set; }
        public int Kategorie { get; set; }

    }
}