using System;

namespace HardwaySI4_PP1.Models
{
    public class Usuarios
    {
        public int? Id { get; set; }

        public string User { get; set; }

        public string password { get; set; }

        public bool Activo { get; set; }

        public DateTime FechaAlta { get; set; }

        public string Observaciones { get; set; }

        public int? IdNivel { get; set; }

        public int IdPersona { get; set; }

        public Personas Personas { get; set; }

        public Niveles Niveles { get; set; }

    }
}
