using DataSoporte2020.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BAL
{
    public class UbicacionManager
    {
        BaseDatos db = new BaseDatos();

        public List<tbl_comuna> ComunaListar(int idpro, int ireg)
        {
            var obj = (from t in db.tbl_comuna where t.idprovincia == idpro && t.idregion == ireg
                       select new
                       {
                           idcomuna = t.idcomuna,
                           desc_comuna = t.desc_comuna,
                           idprovincia = t.idprovincia,
                           idregion = t.idregion
                       }).ToList();

            List<tbl_comuna> lista = (from t in obj
                                      select new tbl_comuna
                          {
                            idcomuna = t.idcomuna,
                            desc_comuna = t.desc_comuna,
                            idprovincia = t.idprovincia,
                            idregion = t.idregion
                        }).ToList();

            return lista;
        }
    }
}