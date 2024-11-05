using System.ComponentModel.DataAnnotations;

namespace HardwaySI4_PP1.Models
{
    public class Localidades
    {
        public int? Id { get; set; }

        public string NombreLocalidad { get; set; }

        public string CodPostal { get; set; }
    }
}
