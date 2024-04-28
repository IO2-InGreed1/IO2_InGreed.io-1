using InGreed.Domain.Models;
using InGreed.Logic.Interfaces;
using Microsoft.AspNetCore.Mvc;

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
    public IActionResult GetById(int id)
    {
        Ingredient? result = _ingredientService.GetById(id);
        if (result is null) return BadRequest();
        return Ok(result);
    }

    [HttpGet]
    public IActionResult GetAll()
    {
        List<Ingredient> result = _ingredientService.GetAll().ToList();
        if (result is null) return BadRequest();
        return Ok(result);
    }

    [HttpPost]
    public IActionResult AddToProduct(Ingredient ingredient, int productId)
    {
        throw new NotImplementedException();
    }

    [HttpPut("{ingredientId}/remove-from-product")]
    public IActionResult RemoveFromProduct(int ingredientId, int productId)
    {
        throw new NotImplementedException();
    }
}
