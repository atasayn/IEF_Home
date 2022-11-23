using System.Text;
using System.Security.Cryptography;


namespace IEF_Home.cls
{
    class Hash
    {
        public static string HashString(string passwordString, string salt)
        {

            byte[] hash_bytes;
            //System.Diagnostics.Debug.WriteLine("SALTTTTTTTT" + salt);
            using (HashAlgorithm algorithm = SHA256.Create())
            {
                hash_bytes = algorithm.ComputeHash(Encoding.UTF8.GetBytes(passwordString + salt + "eco.#"));
                
            }
            var sb = new StringBuilder();
            foreach (var b in hash_bytes)
            {
                sb.Append(b.ToString("X2"));
            }
            return sb.ToString();
        }
    }
}
