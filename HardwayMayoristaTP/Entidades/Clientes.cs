using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HardwaySI4_PP1.Models
{
    public class Clientes
    {
        public int? Id { get; set; }

        public int IdPersona { get; set; }

        public int IdLocalidad { get; set; }

        public Personas Personas { get; set; }

        public Localidades Localidades { get; set; }

    }

}
