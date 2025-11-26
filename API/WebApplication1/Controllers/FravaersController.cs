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
    public class FravaersController : ControllerBase
    {
        private readonly AppDBContext _context;

        public FravaersController(AppDBContext context)
        {
            _context = context;
        }

        // GET: api/Fravaers
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Fravaer>>> GetFravaer()
        {
            return await _context.Fravaer.ToListAsync();
        }

        // GET: api/Fravaers/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Fravaer>> GetFravaer(string id)
        {
            var fravaer = await _context.Fravaer.FindAsync(id);

            if (fravaer == null)
            {
                return NotFound();
            }

            return fravaer;
        }

        // PUT: api/Fravaers/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutFravaer(string id, Fravaer fravaer)
        {
            if (id != fravaer.id)
            {
                return BadRequest();
            }

            _context.Entry(fravaer).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!FravaerExists(id))
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

        // POST: api/Fravaers
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Fravaer>> PostFravaer(Fravaer fravaer)
        {
            _context.Fravaer.Add(fravaer);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (FravaerExists(fravaer.id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetFravaer", new { id = fravaer.id }, fravaer);
        }

        // DELETE: api/Fravaers/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteFravaer(string id)
        {
            var fravaer = await _context.Fravaer.FindAsync(id);
            if (fravaer == null)
            {
                return NotFound();
            }

            _context.Fravaer.Remove(fravaer);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool FravaerExists(string id)
        {
            return _context.Fravaer.Any(e => e.id == id);
        }
    }
}
