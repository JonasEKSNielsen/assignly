using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EgenskabsController : ControllerBase
    {
        private readonly AppDBContext _context;

        public EgenskabsController(AppDBContext context)
        {
            _context = context;
        }

        // GET: api/Egenskabs
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Egenskab>>> GetEgenskab()
        {
            return await _context.Egenskab.ToListAsync();
        }

        // GET: api/Egenskabs/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Egenskab>> GetEgenskab(string id)
        {
            var egenskab = await _context.Egenskab.FindAsync(id);

            if (egenskab == null)
            {
                return NotFound();
            }

            return egenskab;
        }

        // PUT: api/Egenskabs/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutEgenskab(string id, Egenskab egenskab)
        {
            if (id != egenskab.id)
            {
                return BadRequest();
            }

            _context.Entry(egenskab).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!EgenskabExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Egenskabs
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Egenskab>> PostEgenskab(Egenskab egenskab)
        {
            _context.Egenskab.Add(egenskab);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (EgenskabExists(egenskab.id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetEgenskab", new { id = egenskab.id }, egenskab);
        }

        // DELETE: api/Egenskabs/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteEgenskab(string id)
        {
            var egenskab = await _context.Egenskab.FindAsync(id);
            if (egenskab == null)
            {
                return NotFound();
            }

            _context.Egenskab.Remove(egenskab);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool EgenskabExists(string id)
        {
            return _context.Egenskab.Any(e => e.id == id);
        }
    }
}
