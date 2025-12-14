namespace WebApplication1.Models
{
    public enum Hverdag
    {
        Monday,
        Tuesday,
        Wednesday,
        Thursday,
        Friday,
        Saturday,
        Sunday
    }

    public class Nedetid : Common
    {
        public required Hverdag Dag { get; set; }
        public required TimeOnly Tidspunkt { get; set; }
        public required bool Gentagende { get; set; }
        public required DateTime Start { get; set; }
        public required DateTime End { get; set; }
        public required string MaskineId { get; set; }
        public Maskine? Maskine { get; set; }
    }
    // UDEN ID
    public class NedetidDTO
    {
        public required Hverdag Dag { get; set; }
        public required TimeOnly Tidspunkt { get; set; }
        public required bool Gentagende { get; set; }
        public required DateTime Start { get; set; }
        public required DateTime End { get; set; }
        public required string MaskineId { get; set; }
    }
}
