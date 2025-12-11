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
    public class NedetidsController : ControllerBase
    {
        private readonly AppDBContext _context;

        public NedetidsController(AppDBContext context)
        {
            _context = context;
        }

        // GET: api/Nedetids
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Nedetid>>> GetNedetid()
        {
            return await _context.Nedetid.ToListAsync();
        }

        // GET: api/Nedetids/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Nedetid>> GetNedetid(string id)
        {
            var nedetid = await _context.Nedetid.FindAsync(id);

            if (nedetid == null)
            {
                return NotFound();
            }

            return nedetid;
        }

        // PUT: api/Nedetids/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutNedetid(string id, Nedetid nedetid)
        {
            if (id != nedetid.Id)
            {
                return BadRequest();
            }

            _context.Entry(nedetid).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!NedetidExists(id))
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

        // POST: api/Nedetids
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Nedetid>> PostNedetid(NedetidDTO dto)
        {
            Nedetid nedetid = MapDTOToNedetidObject(dto);
            _context.Nedetid.Add(nedetid);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (NedetidExists(nedetid.Id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetNedetid", new { id = nedetid.Id }, nedetid);
        }

        // DELETE: api/Nedetids/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteNedetid(string id)
        {
            var nedetid = await _context.Nedetid.FindAsync(id);
            if (nedetid == null)
            {
                return NotFound();
            }

            _context.Nedetid.Remove(nedetid);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private Nedetid MapDTOToNedetidObject(NedetidDTO dto)
        {
            return new Nedetid
            {
                Id = Guid.NewGuid().ToString("N"),
                Dag = dto.Dag,
                Tidspunkt = dto.Tidspunkt,
                Gentagende = dto.Gentagende,
                Start = dto.Start,
                End = dto.End,
            };
        }
        private bool NedetidExists(string id)
        {
            return _context.Nedetid.Any(e => e.Id == id);
        }
    }
}
