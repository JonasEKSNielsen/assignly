namespace WebApplication1.Models
{
    public class Rolle : Common
    {
        public required string Navn { get; set; }
        public string? medarbejderId { get; set; }
        public Medarbejder? medarbejder { get; set; }
        public string? egenskabId { get; set; }
        public Egenskab? egenskab { get; set; }
    }
    public class RolleDTO
    {
        public required string navn { get; set; }
        public string? medarbejderId { get; set; }
        public Medarbejder? medarbejder { get; set; }
        public string? egenskabId { get; set; }
        public Egenskab? egenskab { get; set; }
    }
}
