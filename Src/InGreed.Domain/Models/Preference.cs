namespace InGreed.Domain.Models;

public class Preference
{
    public int Id { get; set; }
    public int OwnerId { get; set; }
    public string Name { get; set; } = string.Empty;
    private List<Ingredient> Forbidden { get; } = new();
    private List<Ingredient> Preferred { get; } = new();
    
    public bool Active { get; set; } = new();
}
