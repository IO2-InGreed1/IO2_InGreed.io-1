using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using InGreed.Logic.Interfaces;
using System.Security.Claims;

namespace InGreed.Api.Controllers;

[Produces("application/json")]
[Route("api/[controller]")]
[ApiController]
public class UserController : ControllerBase
{
    private readonly IFavouritesService favouritesService;
    public UserController(IFavouritesService service) 
    { 
        favouritesService = service;
    }

    [Authorize]
    [HttpPut("favourites/add/{productId}")]
    public IActionResult AddToFavourites(int productId)
    {
        var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (userId is null) return Unauthorized();
        throw new NotImplementedException();
    }

    [Authorize]
    [HttpDelete("favourites/remove/{productId}")]
    public IActionResult RemoveFromFavourites(int productId)
    {
        var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (userId is null) return Unauthorized();
        throw new NotImplementedException();
    }
}
