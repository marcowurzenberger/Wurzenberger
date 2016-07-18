using BL_Reiseboerse_Graf;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace UI_Reiseboerse_Graf.Models
{
    public class BenutzerCheckerModel
    {
        public void Benutzer_Checker()
        {
            try
            {
                using (testdbEntities context = new testdbEntities())
                {

                }
            }
            catch (Exception ex)
            {

                throw;
            }
            // Ist nur zum Abschreiben da!!!!
            //MYSqlCommand cmd = new MySqlCommand("SELECT benutzer FROM Userinfo WHERE benutzer = '" + textBox1.Text + "';");
            //cmd.Connection = con;
            //SqlDataReader Reader;
            //Reader = cmd.ExecuteReader();
            //string benutzer = Reader.GetValue(0).ToString();
            //con.Close();
            //if (benutzer == textBox1.Text)
            //{

            //    MessageBox.Show("Der Benutzer existiert");
            //}
        }
    }
}