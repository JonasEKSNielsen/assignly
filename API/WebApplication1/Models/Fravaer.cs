namespace WebApplication1.Models
{
    public class Fravaer : Common
    {
        public required DateTime Start { get; set; }
        public required DateTime End { get; set; }
        public required string MedarbejderId { get; set; }
        public Medarbejder? Medarbejder { get; set; }
    }

    public class FravaerDTO
    {
        public required DateTime Start { get; set; }
        public required DateTime End { get; set; }
        public required string MedarbejderId { get; set; }
        public Medarbejder? Medarbejder { get; set; }
    }
}
