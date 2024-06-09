namespace InGreed.Domain.Models;

public class Opinion
{
    public int Id { get; set; }
    public int productId { get; set; }
    public int authorId { get; set; }
    public string Content { get; set; } = string.Empty;
    public float Score { get; set; } = default(float);
    public int reportCount { get; set; } = 0;
}

