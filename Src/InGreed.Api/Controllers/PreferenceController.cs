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
    [Authorize]
    public IActionResult Create(CreateRequest request)
    {
        var id = User.FindFirstValue(ClaimTypes.NameIdentifier);
        if (id is null) return Unauthorized();
        request.preference.OwnerId = int.Parse(id);
        (PreferenceServiceCreateResponse, int) response = service.Create(request.preference);
        if (response.Item1 == PreferenceServiceCreateResponse.InvalidOwnerId) return BadRequest($"Cannot modify Preference as {request.preference.OwnerId} is not a valid OwnerId.");
        if (response.Item1 == PreferenceServiceCreateResponse.ContradictoryPreference) return BadRequest("Cannot modify Preference, referred and forbidden ingredients cannot overlap.");
        return Ok(response.Item2);
    }

    [HttpPut]
    [Authorize]
    public IActionResult Modify(ModifyRequest request, int preferenceToModify) 
    {
        var id = User.FindFirstValue(ClaimTypes.NameIdentifier);
        if (id is null) return Unauthorized();
        Preference temp = service.GetById(preferenceToModify)!;
        if (temp is not null && temp.OwnerId != int.Parse(id)) return Unauthorized($"Preference wirh the id {preferenceToModify} does not belong to the currently logged in user " +
            $"and thus cannot be modified by them.");
        PreferenceServiceModifyResponse response = service.Modify(request.preference, preferenceToModify);
        if (response == PreferenceServiceModifyResponse.NonexistentPreference) return NotFound($"There is no preference with an id {preferenceToModify}.");
        if (response == PreferenceServiceModifyResponse.InvalidOwnerId) return BadRequest($"Cannot modify Preference as {request.preference.OwnerId} is not a valid OwnerId.");
        if (response == PreferenceServiceModifyResponse.ContradictoryPreference) return BadRequest("Cannot modify Preference, referred and forbidden ingredients cannot overlap.");
        return Ok();
    }

    [HttpDelete]
    [Authorize]
    public IActionResult Delete(int id) 
    {
        var userRole = User.FindFirstValue(ClaimTypes.Role);
        if (userRole is null) return Unauthorized();
        else if (userRole != "Moderator" && userRole != "Administrator")
        {
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (userId is null) return Unauthorized();
            Preference temp = service.GetById(id)!;
            if (temp is not null && temp.OwnerId != int.Parse(userId)) return Unauthorized($"Preference with the id {id} does not belong to the currently logged in user " +
                $"and thus cannot be modified by them.");
        }
        PreferenceServiceDeleteResponse response = service.Delete(id);
        if (response == PreferenceServiceDeleteResponse.NonexistentPreference) return NotFound($"There is no preference with an id {id}.");
        return Ok();
    }
}