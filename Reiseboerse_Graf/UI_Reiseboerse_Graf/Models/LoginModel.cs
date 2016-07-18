using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace UI_Reiseboerse_Graf.Models
{
    public class LoginModel
    {
        /// <summary>
        /// Model das an den login gebunden ist und validiert ob passwort und benutzername richtig sind
        /// </summary>
        
        [Required(ErrorMessage = "Pflichtfeld", AllowEmptyStrings = false)]
        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }

        [Required(ErrorMessage = "Pflichtfeld", AllowEmptyStrings = false)]
        [StringLength(16, ErrorMessage = "8-16 Zeichen", MinimumLength = 8)]
        [DataType(DataType.Password)]
        public string Passwort { get; set; }

        [Display(Name = "Möchten Sie angemeldet bleiben?")]
        public bool AngemeldetBleiben { get; set; }

    }
}