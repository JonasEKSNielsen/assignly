using System.ComponentModel.DataAnnotations;

namespace WebApplication1.Models
{
    public class Modul : Common
    {

        public required DateTime Start { get; set; }
        public required DateTime End { get; set; }
        public List<Medarbejder?> Medarbejdere { get; set; } = new List<Medarbejder?>();
    }
    public class ModulDTO
    {

        public required DateTime Start { get; set; }
        public required DateTime End { get; set; }
        public List<string?> MedarbejderIDs { get; set; } = new List<string?>();
    }
}
