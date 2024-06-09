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
        var id = User.FindFirstValue(ClaimTypes.NameIdentifier);
        if (id is null) return Unauthorized();
        int userId = int.Parse(id);
        var response = favouritesService.Add(productId, userId);
        switch (response)
        {
            case Logic.Enums.FavouritesServiceAddResponse.AlreadyInFavourites:
                return BadRequest($"Product with {id} is already in favourites.");
            case Logic.Enums.FavouritesServiceAddResponse.InvalidProductId:
                return NotFound($"There is no product with id {id}.");
            case Logic.Enums.FavouritesServiceAddResponse.InvalidUserId:
                return NotFound($"There is no user with id {id}.");
            case Logic.Enums.FavouritesServiceAddResponse.Success:
                return Ok();
            default:
                return BadRequest();
        }
    }

    [Authorize]
    [HttpDelete("favourites/remove/{productId}")]
    public IActionResult RemoveFromFavourites(int productId)
    {
        var id = User.FindFirstValue(ClaimTypes.NameIdentifier);
        if (id is null) return Unauthorized();
        int userId = int.Parse(id);
        var response = favouritesService.Delete(productId, userId);
        switch (response)
        {
            case Logic.Enums.FavouritesServiceDeleteResponse.NotFavourited:
                return BadRequest($"Product with {id} is not in favourites.");
            case Logic.Enums.FavouritesServiceDeleteResponse.InvalidProductId:
                return NotFound($"There is no product with id {id}.");
            case Logic.Enums.FavouritesServiceDeleteResponse.InvalidUserId:
                return NotFound($"There is no user with id {id}.");
            case Logic.Enums.FavouritesServiceDeleteResponse.Success:
                return Ok();
            default:
                return BadRequest();
        }
    }
}
