using InGreed.Domain.Models;

namespace InGreed.Domain.Helpers
{
    public class ProductWithOwner
    {
        public Product Product {  get; set; }
        public string Owner { get; set; }
    }
}
