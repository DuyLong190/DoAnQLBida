using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using DoAnBida.DAL.Entities;
using System.Security.Cryptography;


namespace DoAnBida
{
    public partial class LoginForm : Form
    {
        public LoginForm()
        {
            InitializeComponent();
        }

        private void LoginForm_Load(object sender, EventArgs e)
        {

        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtAccount.Text;
            string password = txtPassword.Text;
            
            string hashPassword = ComputeHash(password);

            using (var context = new BidaDBContext())
            {
                var user = context.NHANVIENs.FirstOrDefault(x => x.EmployeeName == username && x.Password == password);
                if (user != null)
                {
                    TrangChu trangchu = new TrangChu();
                    trangchu.Show();
                    this.Hide();
                }
                else
                {
                    MessageBox.Show("Sai tên đăng nhập hoặc mật khẩu", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);

                }
            }
        }
        private string ComputeHash(string password)
        {
            using (SHA256 Hash = SHA256.Create())
            {
                // Chuyển đổi chuỗi thành mảng byte và tính toán hash
                byte[] bytes = Hash.ComputeHash(Encoding.UTF8.GetBytes(password));

                // Chuyển đổi mảng byte thành chuỗi
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }

        private void txtPassword_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
