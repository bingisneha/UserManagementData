using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TASK
{
    public partial class _class : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindUserData();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string name = txtName.Text;
                string email = txtEmail.Text;
                int age = Convert.ToInt32(txtAge.Text);
                DateTime dob = Convert.ToDateTime(txtDOB.Text);
                if (!IsValidEmail(email))
                {
                    lblError.Text = "Invalid Email Format!";
                    return;
                }
                if (age <= 0)
                {
                    lblError.Text = "Age must be a positive integer!";
                }
                string connectionstring = "Data Source=DESKTOP-P0GCQ2K;Initial Catalog=testDB;Integrated Security=True;TrustServerCertificate=True";
                using (SqlConnection connection = new SqlConnection(connectionstring))
                {
                    string query = "INSERT INTO UserData (Name, Email, Age, DateOfBirth) VALUES (@Name, @Email, @Age, @DateOfBirth)";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@Name", name);
                        command.Parameters.AddWithValue("@Email", email);
                        command.Parameters.AddWithValue("@Age", age);
                        command.Parameters.AddWithValue("@DateOfBirth", dob);
                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
            }
        }
        private bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }
        private void BindUserData()
        {
            string connectionString = "Data Source=DESKTOP-P0GCQ2K;Initial Catalog=testDB;Integrated Security=True;TrustServerCertificate=True";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT ID, Name, Email, Age, DateOfBirth FROM UserData";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    gvUserData.DataSource = reader;
                    gvUserData.DataBind();
                    reader.Close();
                }
            }
        }
    }
}