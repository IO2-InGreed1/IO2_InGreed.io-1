using InGreed.Api.Contracts.Ingredient;
using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;
using Microsoft.AspNetCore.Mvc;
using InGreed.Logic.Enums;

namespace InGreed.Api.Controllers;

[Route("api/[controller]")]
[ApiController]
public class IngredientController : ControllerBase
{
    IIngredientService _ingredientService;

    public IngredientController(IIngredientService ingredientService)
    {
        _ingredientService = ingredientService;
    }

    [HttpGet("{id}")]
    public IActionResult GetById(GetByIdRequest request)
    {
        Ingredient? result = _ingredientService.GetById(request.id);
        if (result is null) return BadRequest();
        GetByIdResponse response = new(result);
        return Ok(response);
    }

    [HttpGet]
    public IActionResult GetAll()
    {
        List<Ingredient> result = _ingredientService.GetAll().ToList();
        if (result is null) return BadRequest();
        GetAllResponse response = new(result);
        return Ok(response);
    }

    [HttpPost]
    public IActionResult AddToProduct(AdditionRequest request)
    {
        IngredientServiceAddResponse result = _ingredientService.AddToProduct(request.ingredient, request.productId);
        if (result == IngredientServiceAddResponse.Ok) return Ok();
    }

    [HttpPut("{ingredientId}/remove-from-product")]
    public IActionResult RemoveFromProduct(RemovalRequest request)
    {
        throw new NotImplementedException();
    }
}
