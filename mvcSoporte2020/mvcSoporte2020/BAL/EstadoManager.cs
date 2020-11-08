using DataSoporte2020.Data;
using System;
using System.Collections.Generic;
using System.Data.Entity.Migrations;
using System.Linq;
using System.Web;

namespace BAL
{
    public class EstadoManager
    {

        BaseDatos db = new BaseDatos();

        public List<estado> Listar()
        {
            List<estado> lista = db.estado.ToList();
            return lista;
        }

        public estado Buscar(int id)
        {
            estado obj = db.estado.Find(id);
            return obj;
        }

        public int Crear(estado obj)
        {
            db.estado.Add(obj);
            db.SaveChanges();
            return obj.idestado;
        }

        public int Editar(estado obj)
        {
            db.estado.AddOrUpdate(obj);
            db.SaveChanges();
            return obj.idestado;
        }

        public int Borrar(estado obj)
        {
            db.estado.Remove(obj);
            db.SaveChanges();
            return obj.idestado;
        }

    }
}