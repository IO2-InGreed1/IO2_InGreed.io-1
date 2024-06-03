using InGreed.Api.Contracts.Authorization;
using InGreed.Api.Mappers;
using InGreed.Logic.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace InGreed.Api.Controllers;

[Produces("application/json")]
[Route("api/[controller]")]
[ApiController]
public class AccountController : ControllerBase
{
    IAccountService _accountService;
    IContractsToModelsMapper _contractsToModelsMapper;
    public AccountController(IAccountService accountService, 
        IContractsToModelsMapper contractsToModelsMapper)
    {
        _accountService = accountService;
        _contractsToModelsMapper = contractsToModelsMapper;
    }

    [Authorize]
    [HttpGet("currentUser")]
    public IActionResult GetCurrentUser()
    {
        var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if(userId == null)
        {
            return Unauthorized();
        }

        return Ok(_accountService.GetUserById(int.Parse(userId)));
    }

    [HttpPost("register")]
    [ProducesResponseType(typeof(AuthorizationResponse), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesErrorResponseType(typeof(void))]
    public IActionResult Register(RegisterRequest request)
    {
        var user = _contractsToModelsMapper.RegisterRequestToUser(request);
        try
        {
            var token = _accountService.Register(user);
            AuthorizationResponse response = new(token);
            return Ok(response);
        }
        catch
        {
            return BadRequest();
        }
    }

    [HttpPost("login")]
    [ProducesResponseType(typeof(AuthorizationResponse), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesErrorResponseType(typeof(void))]
    [Authorize]
    public IActionResult Login(LoginRequest request)
    {
        var user = _contractsToModelsMapper.LoginRequestToUser(request);
        try
        {
            var token = _accountService.Login(user);
            AuthorizationResponse response = new(token);
            return Ok(response);
        }
        catch
        {
            return Forbid();
        }
    }
}
