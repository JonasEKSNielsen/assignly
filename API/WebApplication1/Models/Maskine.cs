namespace WebApplication1.Models
{
    public class Maskine : Common
    {
        public required string Navn { get; set; }
        public required string EgenskabId { get; set; }
        public Egenskab? Egenskab { get; set; }
    }
    public class MaskineDTO
    {
        public required string Navn { get; set; }
        public required string EgenskabId { get; set; }
    }
}
