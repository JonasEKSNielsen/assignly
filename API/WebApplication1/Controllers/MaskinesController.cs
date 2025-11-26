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
    public class MaskinesController : ControllerBase
    {
        private readonly AppDBContext _context;

        public MaskinesController(AppDBContext context)
        {
            _context = context;
        }

        // GET: api/Maskines
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Maskine>>> GetMaskine()
        {
            return await _context.Maskine.ToListAsync();
        }

        // GET: api/Maskines/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Maskine>> GetMaskine(string id)
        {
            var maskine = await _context.Maskine.FindAsync(id);

            if (maskine == null)
            {
                return NotFound();
            }

            return maskine;
        }

        // PUT: api/Maskines/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutMaskine(string id, Maskine maskine)
        {
            if (id != maskine.id)
            {
                return BadRequest();
            }

            _context.Entry(maskine).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!MaskineExists(id))
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

        // POST: api/Maskines
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Maskine>> PostMaskine(Maskine maskine)
        {
            _context.Maskine.Add(maskine);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (MaskineExists(maskine.id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetMaskine", new { id = maskine.id }, maskine);
        }

        // DELETE: api/Maskines/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteMaskine(string id)
        {
            var maskine = await _context.Maskine.FindAsync(id);
            if (maskine == null)
            {
                return NotFound();
            }

            _context.Maskine.Remove(maskine);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool MaskineExists(string id)
        {
            return _context.Maskine.Any(e => e.id == id);
        }
    }
}
