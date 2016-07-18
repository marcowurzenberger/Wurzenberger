using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace UI_Reiseboerse_Graf.Models
{
    /// <summary>
    /// ReisedetailModel für die Anzeige auf der Detailseite
    /// erbt von ReiseModel
    /// </summary>
    public class ReisedetailModel:ReiseModel
    {
        [Required(ErrorMessage = "Pflichtfeld", AllowEmptyStrings = false)]
        [StringLength(30, MinimumLength = 4, ErrorMessage = "Mind 4 Zeichen")]
        public string Beschreibung { get; set; }

        [Display(Name ="Preis Erwachsene")]
        public decimal Preis_Erwachsene { get; set; }

        [Display(Name = "Preis Kinder")]
        public decimal Preis_Kind { get; set; }

        [Required(ErrorMessage = "Pflichtfeld")]
        public int Unterkunft_ID { get; set; }
    }
}