using InGreed.Api.Contracts.Opinion;
using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;
using Microsoft.AspNetCore.Mvc;
using InGreed.Logic.Enums.Opinion;


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

    [HttpGet("{id}")]
    public IActionResult GetById(int id)
    {
        Opinion? result = _opinionService.GetById(id);
        if (result is null) return NotFound();
        GetByIdResponse response = new(result);
        return Ok(response);
    }

    [HttpPost("/api/Product/{productId}/add-opinion")]
    public IActionResult AddToProduct(AdditionRequest request, int productId)
    {
        OpinionServiceAddResponse result = _opinionService.AddToProduct(request.opinion, productId);
        switch (result)
        {
            case OpinionServiceAddResponse.NonexistentProduct:
                return NotFound($"There is no product with an id {productId}.");
            case OpinionServiceAddResponse.Success:
                return Ok();
            default:
                return BadRequest("Unexpected error.");
        }
    }

    [HttpDelete("/api/Product/{productId}/remove-opinion/{opinionId}")]
    public IActionResult RemoveFromProduct(int opinionId, int productId)
    {
        OpinionServiceRemoveResponse result = _opinionService.RemoveFromProduct(opinionId, productId);
        switch (result)
        {
            case OpinionServiceRemoveResponse.Success:
                return Ok();
            case OpinionServiceRemoveResponse.OpinionNotFromProduct:
                return NotFound($"Product {productId} does not contain an Opinion with an id {opinionId}.");
            case OpinionServiceRemoveResponse.NonexistentProduct:
                return NotFound($"There is no product with an id {productId}.");
            default:
                return BadRequest("Unexpected error.");
        }
    }

    [HttpGet("reported")]
    public IActionResult GetAllReported()
    {
        List<Opinion> result = _opinionService.GetAllReported();
        if (result is null) return BadRequest();
        GetAllReportedResponse response = new(result);
        return Ok(response);
    }
}