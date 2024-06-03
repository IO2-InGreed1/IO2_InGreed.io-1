using InGreed.Domain.Enums;

namespace InGreed.Domain.Models;

public class Preference
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    private List<Ingredient> Forbidden { get; } = new();
    private List<Ingredient> Preferred { get; } = new();
    public Category? Category { get; set; } = null;
    public bool Active { get; set; } = new();
}
