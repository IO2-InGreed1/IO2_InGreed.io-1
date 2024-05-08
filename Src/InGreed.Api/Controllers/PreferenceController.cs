using InGreed.Api.Contracts.Preference;
using InGreed.Logic.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace InGreed.Api.Controllers;

[Route("api/[controller]")]
[ApiController]
public class PreferenceController : ControllerBase
{
    private readonly IPreferenceService service;
    public PreferenceController(IPreferenceService service)
    {
        this.service = service;
    }

    [HttpGet("{id}")]
    public IActionResult GetById(int id)
    {
        throw new NotImplementedException();
    }

    [HttpGet]
    public IActionResult GetByUser()
    {
        throw new NotImplementedException();
    }

    [HttpPost]
    public IActionResult Create(CreateRequest request)
    {
        throw new NotImplementedException();
    }

    [HttpPut]
    public IActionResult Modify(ModifyRequest request, int preferenceToModify) 
    {
        throw new NotImplementedException();
    }

    [HttpDelete]
    public IActionResult Delete(int id) 
    {  
        throw new NotImplementedException(); 
    }
}