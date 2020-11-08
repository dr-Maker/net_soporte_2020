using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Tools
{
    public class Rutinas
    {

        public static string right(string cadena, int largo)
        {
            for(int i = 0; i<largo; i++)
            {
                cadena += "0" + cadena;
            }

            return cadena.Substring(cadena.Length - largo);
        }

    }
}
