using InGreed.Api.Contracts.Preference;
using InGreed.Logic.Interfaces;
using Microsoft.AspNetCore.Mvc;
using InGreed.Domain.Models;
using InGreed.Logic.Enums.Preference;
using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;

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
        Preference? result = service.GetById(id);
        if (result is null) return NotFound($"There is no preference with an id {id}.");
        return Ok(new GetByIdResponse(result));
    }

    [HttpGet]
    [Authorize]
    public IActionResult GetByUser()
    {
        if (User is null) return Unauthorized();
        var id = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (id is null) return Unauthorized();
        int userId = int.Parse(id);
        var result = service.GetByUser(userId);
        if (result is null) return NotFound();
        return Ok(new GetByUserResponse(result.ToList()));
    }

    [HttpPost]
    public IActionResult Create(CreateRequest request)
    {
        (PreferenceServiceCreateResponse, int) response = service.Create(request.preference);
        if (response.Item1 == PreferenceServiceCreateResponse.InvalidOwnerId) return BadRequest($"Cannot modify Preference as {request.preference.OwnerId} is not a valid OwnerId.");
        if (response.Item1 == PreferenceServiceCreateResponse.ContradictoryPreference) return BadRequest("Cannot modify Preference, referred and forbidden ingredients cannot overlap.");
        return Ok(response.Item2);
    }

    [HttpPut]
    public IActionResult Modify(ModifyRequest request, int preferenceToModify) 
    {
        PreferenceServiceModifyResponse response = service.Modify(request.preference, preferenceToModify);
        if (response == PreferenceServiceModifyResponse.NonexistentPreference) return NotFound($"There is no preference with an id {preferenceToModify}.");
        if (response == PreferenceServiceModifyResponse.InvalidOwnerId) return BadRequest($"Cannot modify Preference as {request.preference.OwnerId} is not a valid OwnerId.");
        if (response == PreferenceServiceModifyResponse.ContradictoryPreference) return BadRequest("Cannot modify Preference, referred and forbidden ingredients cannot overlap.");
        return Ok();
    }

    [HttpDelete]
    public IActionResult Delete(int id) 
    {  
        PreferenceServiceDeleteResponse response = service.Delete(id);
        if (response == PreferenceServiceDeleteResponse.NonexistentPreference) return NotFound($"There is no preference with an id {id}.");
        return Ok();
    }
}