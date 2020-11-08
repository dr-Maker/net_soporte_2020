using DataSoporte2020.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BAL
{
    public class PersonaManager
    {
        BaseDatos db = new BaseDatos();

        
        public List<persona> Listar()
        {
            return db.persona.ToList();
        }

        public persona Listar(int id)
        {
            return db.persona.Find(id);
        }

        public long Crear(persona obj)
        {
            db.persona.Add(obj);
            db.SaveChanges();
            return obj.idpersona;
        }


    }
}