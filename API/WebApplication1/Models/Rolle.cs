namespace WebApplication1.Models
{
    public class Rolle : Common
    {
        public string navn { get; set; }
        public string medarbejderId { get; set; }
        public Medarbejder medarbejder { get; set; }
        public string egenskabId { get; set; }
        public Egenskab egenskab { get; set; }
    }
}
