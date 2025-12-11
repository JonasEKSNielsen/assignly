namespace WebApplication1.Models
{
    public class Medarbejder : Common
    {
        public required string Navn { get; set; }
        public required string Email { get; set; }
        public required string Password { get; set; }
        public required DateTime ArbejdsdagStart { get; set; }
        public required DateTime ArbejdsdagSlut { get; set; }
        public required int ArbejdstimerOmUgen { get; set; }

        // IKKE TIL PRODUKTION
        public required string RealPassword { get; set; }

        public string? Tlf { get; set; }
        public string? Farve { get; set; }
        List<Modul?> Moduler { get; set; } = new List<Modul?>();
        List<Fravaer?> Fravaer { get; set; } = new List<Fravaer?>();
        public List<Rolle?> Roller { get; set; } = new List<Rolle?>();
    }
    public class SignupDTO
    {
        public required string Navn { get; set; }
        public required string Email { get; set; }
        public required string Password { get; set; }
        public required DateTime ArbejdsdagStart { get; set; }
        public required DateTime ArbejdsdagSlut { get; set; }
        public required int ArbejdstimerOmUgen { get; set; }
        public string? Tlf { get; set; }
        public string? Farve { get; set; }
    }
    public class LoginDTO
    {
        public required string Email { get; set; }
        public required string Password { get; set; }
    }
}
