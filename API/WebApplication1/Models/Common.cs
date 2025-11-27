using System.ComponentModel.DataAnnotations;

namespace WebApplication1.Models
{
    public class Common
    {
        [Key]
        public required string Id { get; set; }
    }
}
