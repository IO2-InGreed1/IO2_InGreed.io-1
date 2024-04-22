using InGreed.Api.Contracts.Authorization;
using InGreed.Logic.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace InGreed.Api.Controllers;

[Route("api/[controller]")]
[ApiController]
public class AccountController : ControllerBase
{
    IAccountService _accountService;
    public AccountController(IAccountService accountService)
    {
        _accountService = accountService;
    }

    [HttpPost("register")]
    public IActionResult Register(RegisterRequest request)
    {
        throw new NotImplementedException();
    }

    [HttpPost("login")]
    public IActionResult Login(LoginRequest request)
    {
        //var token = _accountService.Login(request);
        //AuthorizationResponse response = new(token);
        //return Ok(response);
        return Ok();
    }
}
