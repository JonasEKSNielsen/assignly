namespace WebApplication1.Models
{
    public class Rolle : Common
    {
        public required string Navn { get; set; }
        public List<Egenskab?> Egenskaber { get; set; } = new List<Egenskab?>();
    }
    public class RolleDTO
    {
        public required string navn { get; set; }
        public List<string> EgenskabIds { get; set; } = new List<string>();
    }
}
