namespace WebApplication1.Models
{
    public class Periode : Common
    {
        public required DateTime Start { get; set; }
        public required DateTime End { get; set; }
        public List<Modul?> Moduler { get; set; } = new List<Modul?>();
    }
    public class PeriodeDTO 
    {
        public required DateTime Start { get; set; }
        public required DateTime End { get; set; }
        public List<Modul?> Moduler { get; set; } = new List<Modul?>();
    }
}
