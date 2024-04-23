﻿using InGreed.Api.Contracts.Authorization;
using InGreed.Api.Mappers;
using InGreed.Logic.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace InGreed.Api.Controllers;

[Route("api/[controller]")]
[ApiController]
public class AccountController : ControllerBase
{
    IAccountService _accountService;
    IContractsToModelsMapper _contractsToModelsMapper;
    public AccountController(IAccountService accountService, IContractsToModelsMapper contractsToModelsMapper)
    {
        _accountService = accountService;
        _contractsToModelsMapper = contractsToModelsMapper;
    }

    [HttpPost("register")]
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
