using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HardwaySI4_PP1.Models
{
    public class Personas
    {
        public int? Id { get; set; }

        public string Dni { get; set; }

        public string NombreApellido { get; set; }

        public string Email { get; set; }

        public string Telefono { get; set; }

        public int IdTipoDni { get; set; }

        public TipoDni TipoDni { get; set; }

    }
}
