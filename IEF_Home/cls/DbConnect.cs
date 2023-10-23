using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Diagnostics;
using System.IO;


namespace IEF_Home.cls
{
    public class DbConnect
    {
        public MySqlConnection Connection;
        public string Server;
        public string Database;
        public string Uid;
        public string Password;

        //Constructor
        public DbConnect()
        {
            Initialize();
        }

        //Initialize values
        public void Initialize()
        {
            Server = ConfigurationManager.AppSettings["dbServer"];
            Database = ConfigurationManager.AppSettings["dbName"];
            Uid = ConfigurationManager.AppSettings["dbUser"];
            Password = ConfigurationManager.AppSettings["dbPassword"];
            var connectionString = "SERVER=" + Server + ";" + "DATABASE=" + Database + ";" + "UID=" + Uid + ";" + "PASSWORD=" + Password + ";";

            Connection = new MySqlConnection(connectionString);
        }


        //open Connection to database
        public bool OpenConnection()
        {
            try
            {
                Connection.Open();
                return true;
            }
            catch (MySqlException ex)
            {
                //When hANDling errors, you can your application's response based on the error number.
                //The two most common error numbers when connecting are as follows:
                //0: Cannot connect to Server.
                //1045: Invalid user name AND/or password.
                switch (ex.Number)
                {
                    case 0:
                        //MessageBox.Show("Cannot connect to Server.  Contact administrator");
                        break;

                    case 1045:
                        //MessageBox.Show("Invalid username/password, please try again");
                        break;
                }
                return false;
            }
        }

        //Close Connection
        public bool CloseConnection()
        {
            try
            {
                Connection.Close();
                return true;
            }
            catch (MySqlException)
            {
                return false;
            }
        }

        //Backup
        public void Backup()
        {
            try
            {
                var Time = DateTime.Now;
                var year = Time.Year;
                var month = Time.Month;
                var day = Time.Day;
                var hour = Time.Hour;
                var minute = Time.Minute;
                var second = Time.Second;
                var millisecond = Time.Millisecond;

                //Save file to C:\ with the current date as a filename
                var path = "C:\\" + year + "-" + month + "-" + day + "-" + hour + "-" + minute + "-" + second + "-" + millisecond + ".sql";
                var file = new StreamWriter(path);


                var psi = new ProcessStartInfo
                {
                    FileName = "mysqldump",
                    RedirectStandardInput = false,
                    RedirectStandardOutput = true,
                    Arguments = $@"-u{Uid} -p{Password} -h{Server} {Database}",
                    UseShellExecute = false
                };

                var process = Process.Start(psi);
                if (process == null) return;
                var output = process.StandardOutput.ReadToEnd();
                file.WriteLine(output);
                process.WaitForExit();
                file.Close();
                process.Close();
            }
            catch (IOException)
            {
            }
        }

        //Restore
        public void Restore()
        {
            try
            {
                //Read file FROM C:\
                const string path = "C:\\MySqlBackup.sql";
                var file = new StreamReader(path);
                var input = file.ReadToEnd();
                file.Close();


                var psi = new ProcessStartInfo
                {
                    FileName = "mysql",
                    RedirectStandardInput = true,
                    RedirectStandardOutput = false,
                    Arguments = $@"-u{Uid} -p{Password} -h{Server} {Database}",
                    UseShellExecute = false
                };


                var process = Process.Start(psi);
                if (process == null) return;
                process.StandardInput.WriteLine(input);
                process.StandardInput.Close();
                process.WaitForExit();
                process.Close();
            }
            catch (IOException)
            {
            }
        }
    }
}
