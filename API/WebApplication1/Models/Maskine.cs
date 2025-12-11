namespace WebApplication1.Models
{
    public class Maskine : Common
    {
        public required string Navn { get; set; }
        public required string EgenskabId { get; set; }
        public Egenskab? Egenskab { get; set; }
        public List<Modul?> Moduler { get; set; } = new List<Modul?>();
        public List<Nedetid?> Nedetider { get; set; } = new List<Nedetid?>();
    }
    public class MaskineDTO
    {
        public required string Navn { get; set; }
        public required string EgenskabId { get; set; }
        public List<string?> ModuleIds { get; set; } = new List<string?>();
        public List<string?> NedetidIds { get; set; } = new List<string?>();
    }
}
