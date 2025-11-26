namespace WebApplication1.Models
{
    public class Periode : Common
    {
        public DateTime start { get; set; }
        public DateTime end { get; set; }
        public List<Modul> moduler { get; set; }
    }
}
