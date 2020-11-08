using BAL;
using DataSoporte2020.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Controllers
{
    public class PersonaController : Controller
    {
        PersonaManager man = new PersonaManager();

        [HttpGet]
        public ActionResult Index()
        {
            return View(man.Listar());
        }

        [HttpGet]
        public ActionResult Crear()
        {
            UbicacionManager uman = new UbicacionManager();
            ViewBag.Comunas = uman.ComunaListar(131,13);
            return View();
        }

        [HttpPost]
        public ActionResult Crear(FormCollection frm)
        {
            UbicacionManager uman = new UbicacionManager();
            ViewBag.Comunas = uman.ComunaListar(131, 13);

           persona obj = new persona();
            obj.rut = frm["rut"].ToString();
            obj.dv = frm["dv"].ToString();
            obj.ap_paterno = frm["ap_paterno"].ToString();
            obj.ap_materno = frm["ap_materno"].ToString();
            obj.nombres = frm["nombres"].ToString();
            obj.email = frm["email"].ToString();
            obj.telefono = int.Parse(frm["telefono"].ToString());
            obj.dir_calle = frm["dir_calle"].ToString();
            obj.dir_numero = int.Parse(frm["dir_numero"].ToString());
            obj.idcomuna = int.Parse(frm["idcomuna"].ToString());

            man.Crear(obj);


            return RedirectToAction("Index");
        }


    }
}