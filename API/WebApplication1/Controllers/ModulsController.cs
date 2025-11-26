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
    public class ModulsController : ControllerBase
    {
        private readonly AppDBContext _context;

        public ModulsController(AppDBContext context)
        {
            _context = context;
        }

        // GET: api/Moduls
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Modul>>> GetModul()
        {
            return await _context.Modul.ToListAsync();
        }

        // GET: api/Moduls/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Modul>> GetModul(string id)
        {
            var modul = await _context.Modul.FindAsync(id);

            if (modul == null)
            {
                return NotFound();
            }

            return modul;
        }

        // PUT: api/Moduls/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutModul(string id, Modul modul)
        {
            if (id != modul.id)
            {
                return BadRequest();
            }

            _context.Entry(modul).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ModulExists(id))
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

        // POST: api/Moduls
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Modul>> PostModul(Modul modul)
        {
            _context.Modul.Add(modul);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (ModulExists(modul.id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetModul", new { id = modul.id }, modul);
        }

        // DELETE: api/Moduls/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteModul(string id)
        {
            var modul = await _context.Modul.FindAsync(id);
            if (modul == null)
            {
                return NotFound();
            }

            _context.Modul.Remove(modul);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool ModulExists(string id)
        {
            return _context.Modul.Any(e => e.id == id);
        }
    }
}
