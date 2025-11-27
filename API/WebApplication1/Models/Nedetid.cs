namespace WebApplication1.Models
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

    public class Nedetid : Common
    {
        public required Hverdag Dag { get; set; }
        public required TimeOnly Tidspunkt { get; set; }
        public required bool Gentagende { get; set; }
        public required DateTime Start { get; set; }
        public required DateTime End { get; set; }
    }
    public class NedetidDTO
    {
        public required Hverdag Dag { get; set; }
        public required TimeOnly Tidspunkt { get; set; }
        public required bool Gentagende { get; set; }
        public required DateTime? Start { get; set; }
        public required DateTime? End { get; set; }
    }
}
