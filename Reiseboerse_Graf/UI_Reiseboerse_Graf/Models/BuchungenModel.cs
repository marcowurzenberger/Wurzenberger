using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace UI_Reiseboerse_Graf.Models
{
    public class BuchungenModel : KundenAnlegenModel
    {
        [Required(ErrorMessage = "Pflichtfeld!", AllowEmptyStrings = false)]
        public int ReisePassNummer { get; set; }
        [Required(ErrorMessage = "Pflichtfeld!", AllowEmptyStrings = false)]
        public int Zahlungsart_id { get; set; }
        [Required(ErrorMessage = "Pflichtfeld!", AllowEmptyStrings = false)]
        public int Versicherung_id { get; set; }



    }
}