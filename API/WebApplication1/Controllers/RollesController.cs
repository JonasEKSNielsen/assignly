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
    public class RollesController : ControllerBase
    {
        private readonly AppDBContext _context;

        public RollesController(AppDBContext context)
        {
            _context = context;
        }

        // GET: api/Rolles
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Rolle>>> GetRolle()
        {
            return await _context.Rolle.ToListAsync();
        }

        // GET: api/Rolles/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Rolle>> GetRolle(string id)
        {
            var rolle = await _context.Rolle.FindAsync(id);

            if (rolle == null)
            {
                return NotFound();
            }

            return rolle;
        }

        // PUT: api/Rolles/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutRolle(string id, Rolle rolle)
        {
            if (id != rolle.id)
            {
                return BadRequest();
            }

            _context.Entry(rolle).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!RolleExists(id))
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

        // POST: api/Rolles
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Rolle>> PostRolle(Rolle rolle)
        {
            _context.Rolle.Add(rolle);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (RolleExists(rolle.id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetRolle", new { id = rolle.id }, rolle);
        }

        // DELETE: api/Rolles/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteRolle(string id)
        {
            var rolle = await _context.Rolle.FindAsync(id);
            if (rolle == null)
            {
                return NotFound();
            }

            _context.Rolle.Remove(rolle);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool RolleExists(string id)
        {
            return _context.Rolle.Any(e => e.id == id);
        }
    }
}
