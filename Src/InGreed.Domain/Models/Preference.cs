namespace InGreed.Domain.Models;

public class Preference
{
    public int Id { get; set; }
    public int OwnerId { get; set; }
    public string Name { get; set; } = string.Empty;
    public List<Ingredient> Forbidden { get; } = new();
    public List<Ingredient> Preferred { get; } = new();
    
    public bool Active { get; set; } = new();
}
