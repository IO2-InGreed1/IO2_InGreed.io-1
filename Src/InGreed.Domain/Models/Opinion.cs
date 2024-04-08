namespace InGreed.Domain.Models;

public class Opinion : Base
{
    public Product Product { get; set; }
    public User Author {  get; set; }
    public string Content { get; set; } = string.Empty;
    public float Score { get; set; }

    public void CalculateScore(float rating)
    {
        throw new NotImplementedException();
    }

    public void Report()
    {
        throw new NotImplementedException();
    }

    public void Rate(float rating)
    {
        throw new NotImplementedException();
    }
}

