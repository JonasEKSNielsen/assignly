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
    public class PeriodesController : ControllerBase
    {
        private readonly AppDBContext _context;

        public PeriodesController(AppDBContext context)
        {
            _context = context;
        }

        // GET: api/Periodes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Periode>>> GetPeriode()
        {
            return await _context.Periode.ToListAsync();
        }

        // GET: api/Periodes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Periode>> GetPeriode(string id)
        {
            var periode = await _context.Periode.FindAsync(id);

            if (periode == null)
            {
                return NotFound();
            }

            return periode;
        }

        // PUT: api/Periodes/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutPeriode(string id, Periode periode)
        {
            if (id != periode.id)
            {
                return BadRequest();
            }

            _context.Entry(periode).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!PeriodeExists(id))
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

        // POST: api/Periodes
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Periode>> PostPeriode(Periode periode)
        {
            _context.Periode.Add(periode);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (PeriodeExists(periode.id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetPeriode", new { id = periode.id }, periode);
        }

        // DELETE: api/Periodes/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletePeriode(string id)
        {
            var periode = await _context.Periode.FindAsync(id);
            if (periode == null)
            {
                return NotFound();
            }

            _context.Periode.Remove(periode);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool PeriodeExists(string id)
        {
            return _context.Periode.Any(e => e.id == id);
        }
    }
}
