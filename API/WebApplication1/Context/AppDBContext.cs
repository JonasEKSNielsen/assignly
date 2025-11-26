using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Client;
using WebApplication1.Models;

public class AppDBContext : DbContext
{
    public AppDBContext(DbContextOptions<AppDBContext> options)
        : base(options)
    {
    }

public DbSet<WebApplication1.Models.Egenskab> Egenskab { get; set; } = default!;

public DbSet<WebApplication1.Models.Fravaer> Fravaer { get; set; } = default!;

public DbSet<WebApplication1.Models.Maskine> Maskine { get; set; } = default!;

public DbSet<WebApplication1.Models.Medarbejder> Medarbejder { get; set; } = default!;

public DbSet<WebApplication1.Models.Modul> Modul { get; set; } = default!;

public DbSet<WebApplication1.Models.Nedetid> Nedetid { get; set; } = default!;

public DbSet<WebApplication1.Models.Periode> Periode { get; set; } = default!;

public DbSet<WebApplication1.Models.Rolle> Rolle { get; set; } = default!;

}