namespace WebApplication1.Models
{
    public class Maskine : Common
    {
        public string navn { get; set; }
        public string egenskabId { get; set; }
        public Egenskab egenskab { get; set; }
        public List<Modul> moduler { get; set; }
        public List<Nedetid> nedetider { get; set; }
    }
}
