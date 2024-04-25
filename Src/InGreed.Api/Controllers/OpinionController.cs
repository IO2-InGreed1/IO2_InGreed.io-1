using InGreed.Api.Mappers;
using InGreed.Logic.Interfaces;
using InGreed.Logic.Services;
using Microsoft.AspNetCore.Mvc;

namespace InGreed.Api.Controllers;

[Route("api/[controller]")]
[ApiController]
public class OpinionController : ControllerBase
{
    IOpinionService _opinionService;

    public OpinionController(IOpinionService opinionService)
    {
        _opinionService = opinionService;
    }
}