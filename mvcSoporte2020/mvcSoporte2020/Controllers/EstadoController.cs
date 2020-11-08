using BAL;
using DataSoporte2020.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Controllers
{
    public class EstadoController : Controller
    {
        EstadoManager man = new EstadoManager();

        [HttpGet]
        public ActionResult Index()
        {
            List<estado> lista = man.Listar();
            return View(lista);
        }

        [HttpGet]
        public ActionResult Crear()
        {
         
            return View();
        }

        [HttpPost]
        public ActionResult Crear(FormCollection frm)
        {
            estado obj = new estado();
            obj.idestado = int.Parse(frm["idestado"].ToString());
            obj.desc_estado = frm["desc_estado"].ToString();
            int identity = man.Crear(obj);
            return RedirectToAction("Index");
        }

        [HttpGet]
        public ActionResult Editar(int id)
        {
            var obj =  man.Buscar(id);
            return View(obj);
        }

        [HttpPost]
        public ActionResult Editar(int id, FormCollection frm)
        {
            estado obj = man.Buscar(id);

            obj.desc_estado = frm["desc_estado"].ToString();
            int identity = man.Editar(obj);
            return RedirectToAction("Index");
        }

        [HttpGet]
        public ActionResult Borrar(int id)
        {
            var obj = man.Buscar(id);
            return View(obj);
        }

        [HttpPost]
        public ActionResult Borrar(int id, FormCollection frm)
        {
            estado obj = man.Buscar(id); 
            int identity = man.Borrar(obj);
            return RedirectToAction("Index");
        }

    }
}