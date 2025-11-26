namespace WebApplication1.Models
{
    public class Fravaer : Common
    {
        public DateTime start { get; set; }
        public DateTime end { get; set; }
        public string aarsag { get; set; }
        public string medarbejderId { get; set; }
        public Medarbejder medarbejder { get; set; }
    }
}
