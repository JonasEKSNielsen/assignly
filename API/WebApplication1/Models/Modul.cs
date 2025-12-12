using System.ComponentModel.DataAnnotations;

namespace WebApplication1.Models
{
    public class Modul : Common
    {

        public required DateTime Start { get; set; }
        public required DateTime End { get; set; }
        public string? MedarbejderId { get; set; }
        public Medarbejder? Medarbejder { get; set; }
    }
    public class ModulDTO
    {
        public required DateTime Start { get; set; }
        public required DateTime End { get; set; }
        public string? MedarbejderId { get; set; }
    }
}
