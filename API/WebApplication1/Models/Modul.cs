using System.ComponentModel.DataAnnotations;

namespace WebApplication1.Models
{
    public class Modul : Common
    {

        public DateTime start { get; set; }
        public DateTime end { get; set; }
        public string periodeId { get; set; }
        public Periode periode { get; set; }
        public List<Medarbejder> medarbejdere { get; set; }
        public List<Maskine> maskiner { get; set; }
    }
}
