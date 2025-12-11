using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.CodeAnalysis.Scripting;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
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
            if (id != medarbejder.Id)
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
        public async Task<ActionResult<Medarbejder>> PostMedarbejder(SignupDTO newMedarbejder)
        {
            if (await _context.Medarbejder.AnyAsync(item => item.Navn == newMedarbejder.Navn))
            {
                return Conflict(new { message = "Username is already in use." });
            }

            if (await _context.Medarbejder.AnyAsync(item => item.Email == newMedarbejder.Email))
            {
                return Conflict(new { message = "Email is already in use." });
            }
            else if (!isValidEmail(newMedarbejder.Email))
            {
                return Conflict(new { message = "Email is not valid." });
            }

            if (!IsPasswordSecure(newMedarbejder.Password))
            {
                return Conflict(new { message = "Password is not secure." });
            }

            var medarbejder = MapSignUpDTOToMedarbejder(newMedarbejder);

            _context.Medarbejder.Add(medarbejder);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (MedarbejderExists(medarbejder.Id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetMedarbejder", new { id = medarbejder.Id }, medarbejder);
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

        private bool IsPasswordSecure(string password)
        {
            var hasUpperCase = new Regex(@"[A-Z]+");
            var hasLowerCase = new Regex(@"[a-z]+");
            var hasDigits = new Regex(@"[0-9]+");
            var hasSpecialChar = new Regex(@"[\W_]+");
            var hasMinimum8Chars = new Regex(@".{8,}");

            return hasUpperCase.IsMatch(password)
                   && hasLowerCase.IsMatch(password)
                   && hasDigits.IsMatch(password)
                   && hasSpecialChar.IsMatch(password)
                   && hasMinimum8Chars.IsMatch(password);
        }

        private bool isValidEmail(string Email)
        {
            return new Regex(@"(?>(?:[0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+)[a-zA-Z]{2,9}").IsMatch(Email);
        }
        private Medarbejder MapSignUpDTOToMedarbejder(SignupDTO signUpDTO)
        {
            String hashedPassword = BCrypt.Net.BCrypt.HashPassword(signUpDTO.Password);
            String salt = hashedPassword.Substring(0, 29);

            return new Medarbejder
            {
                Id = Guid.NewGuid().ToString("N"),
                Email = signUpDTO.Email,
                Navn = signUpDTO.Navn,
                Password = hashedPassword,
                ArbejdsdagStart = signUpDTO.ArbejdsdagStart,
                ArbejdsdagSlut = signUpDTO.ArbejdsdagSlut,
                ArbejdstimerOmUgen = signUpDTO.ArbejdstimerOmUgen,
                // REMOVE FROM PRODUCTION
                RealPassword = signUpDTO.Password,
                Tlf = signUpDTO.Tlf,
                Farve = signUpDTO.Farve
            };
        }
        private bool MedarbejderExists(string id)
        {
            return _context.Medarbejder.Any(e => e.Id == id);
        }
    }
}
