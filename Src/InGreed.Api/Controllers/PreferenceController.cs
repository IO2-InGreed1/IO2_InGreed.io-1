using InGreed.Api.Contracts.Ingredient;
using InGreed.Domain.Models;
using Microsoft.AspNetCore.Mvc;

namespace InGreed.Api.Controllers;

[Route("api/[controller]")]
[ApiController]
public class PreferenceController : ControllerBase
{
    public PreferenceController()
    {

    }

    [HttpGet("{id}")]
    public IActionResult GetById(int id)
    {
        throw new NotImplementedException();
    }

    [HttpGet("user-{userId}")]
    public IActionResult GetByUser(int userId)
    {
        throw new NotImplementedException();
    }

    [HttpPut]
    public IActionResult Modify(Preference preference, int preferenceToModify) 
    {
        throw new NotImplementedException();
    }

    [HttpDelete]
    public IActionResult Delete(int id) 
    {  
        throw new NotImplementedException(); 
    }
}