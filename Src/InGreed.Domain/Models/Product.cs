using InGreed.Domain.Enums;

namespace InGreed.Domain.Models;

public class Product : Base
{
    public string Name { get; set; } = string.Empty;
    public DateTime? PromotedUntil { get; } = null;
    private List<Ingredient> _ingredients = new();
    public List<Opinion> Opinions = new();
    public Category Category { get; set; } = Category.Other;

    public void AddIngredient(Ingredient ingredient)
    {
        throw new NotImplementedException();
    }

    public void RemoveIngredient(Ingredient ingredient)
    {
        throw new NotImplementedException();
    }

    public void AddOpinion()
    {
        throw new NotImplementedException();
    }

    public void PromoteUntil(DateTime until)
    {
        throw new NotImplementedException();
    }

    public List<Ingredient> GetIngredients() 
    {
        throw new NotImplementedException();
    }
}
