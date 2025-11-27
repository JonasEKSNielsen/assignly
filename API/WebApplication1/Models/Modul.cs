using System.ComponentModel.DataAnnotations;

namespace WebApplication1.Models
{
    public class Modul : Common
    {

        public required DateTime Start { get; set; }
        public required DateTime End { get; set; }
        public required string PeriodeId { get; set; }
        public Periode? Periode { get; set; }
        public List<Medarbejder?> Medarbejdere { get; set; } = new List<Medarbejder?>();
        public List<Maskine?> Maskiner { get; set; } = new List<Maskine?>();
    }
    public class ModulDTO : Common
    {

        public required DateTime Start { get; set; }
        public required DateTime End { get; set; }
        public required string PeriodeId { get; set; }
        public Periode? Periode { get; set; }
        public List<Medarbejder?> Medarbejdere { get; set; } = new List<Medarbejder?>();
        public List<Maskine?> Maskiner { get; set; } = new List<Maskine?>();
    }
}
