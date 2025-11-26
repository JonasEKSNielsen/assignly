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
    public class MedarbejdersController : ControllerBase
    {
        private readonly AppDBContext _context;

        public MedarbejdersController(AppDBContext context)
        {
            _context = context;
        }

        // GET: api/Medarbejders
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Medarbejder>>> GetMedarbejder()
        {
            return await _context.Medarbejder.ToListAsync();
        }

        // GET: api/Medarbejders/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Medarbejder>> GetMedarbejder(string id)
        {
            var medarbejder = await _context.Medarbejder.FindAsync(id);

            if (medarbejder == null)
            {
                return NotFound();
            }

            return medarbejder;
        }

        // PUT: api/Medarbejders/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutMedarbejder(string id, Medarbejder medarbejder)
        {
            if (id != medarbejder.id)
            {
                return BadRequest();
            }

            _context.Entry(medarbejder).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!MedarbejderExists(id))
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

        // POST: api/Medarbejders
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Medarbejder>> PostMedarbejder(Medarbejder medarbejder)
        {
            _context.Medarbejder.Add(medarbejder);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (MedarbejderExists(medarbejder.id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetMedarbejder", new { id = medarbejder.id }, medarbejder);
        }

        // DELETE: api/Medarbejders/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteMedarbejder(string id)
        {
            var medarbejder = await _context.Medarbejder.FindAsync(id);
            if (medarbejder == null)
            {
                return NotFound();
            }

            _context.Medarbejder.Remove(medarbejder);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool MedarbejderExists(string id)
        {
            return _context.Medarbejder.Any(e => e.id == id);
        }
    }
}
