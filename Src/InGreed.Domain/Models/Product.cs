using InGreed.Domain.Enums;

namespace InGreed.Domain.Models;

public class Product
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public DateTime? PromotedUntil { get; set; } = null;
    public List<Ingredient> Ingredients { get; } = new();
    public List<Opinion> Opinions { get; } = new();
    public Category Category { get; set; } = Category.Other;
}
