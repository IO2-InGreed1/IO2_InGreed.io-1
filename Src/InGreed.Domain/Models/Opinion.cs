namespace InGreed.Domain.Models;

public class Opinion
{
    public int Id { get; set; }
    public Product Product { get; set; } = null!;
    public User Author { get; set; } = null!;
    public string Content { get; set; } = string.Empty;
    public float Score { get; set; }
}

