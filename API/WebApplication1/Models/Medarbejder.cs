namespace WebApplication1.Models
{
    public class Medarbejder : Common
    {
        public string navn { get; set; }
        public string tlf { get; set; }
        List<Modul> moduler { get; set; }
        List<Fravaer> fravaer { get; set; }
        List<Rolle> roller { get; set; }
    }
}
