using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace DoAnBida.BUS
{
    public class MaHoaMK
    {
        private static MaHoaMK instance;
        public static MaHoaMK Instance
        {
            get
            {
                if (instance == null) instance = new MaHoaMK();
                return instance;
            }
            private set { instance = value; }
        }
        private MaHoaMK() { }

       
        }
    }

