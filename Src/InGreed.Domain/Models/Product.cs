using InGreed.Domain.Enums;

namespace InGreed.Domain.Models;

public class Product
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public DateTime? PromotedUntil { get; set; } = null;
    public List<Ingredient> Ingredients { get; set; } = new();
    public Category Category { get; set; } = Category.Other;
    public string IconURL { get; set; } = string.Empty;
    public int ProducentId { get; set; }
    public int ReportCount { get; set; } = 0;
    public string Description {  get; set; } = string.Empty;
}
