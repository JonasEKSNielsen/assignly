namespace WebApplication1.Models
{
    public class Nedetid : Common
    {
        public enum Hverdag
        {
            Mandag,
            Tirsdag,
            Onsdag,
            Torsdag,
            Fredag,
            Lørdag,
            Søndag
        }
        public Hverdag dag { get; set; }
        public TimeOnly tidspunkt { get; set; }
        public bool gentagende { get; set; }
        public DateTime start { get; set; }
        public DateTime end { get; set; }
    }
}
