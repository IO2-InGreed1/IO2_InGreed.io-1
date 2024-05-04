using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Models;
using InGreed.Domain.Enums;

namespace InGreed.DataAccess.FakeDA;

public class FakeProductDA : IProductDA
{
    private static List<Product> _products = new()
    {
        new() {Id = 1, Name = "Fermented Spider Eye", PromotedUntil = new(2137, 3, 26), Category = Category.Other},
        new() {Id = 2, Name = "Chorus Fruit", PromotedUntil = null, Category = Category.Food},
        new() {Id = 3, Name = "Potion of Fire Resistance", PromotedUntil = null, Category = Category.Drinks }
    };
    private int currentId = 3;

    public int CreateProduct(Product product)
    {
        product.Id = ++currentId;
        _products.Add(product);
        return currentId;
    }

    public IEnumerable<Product> GetAll()
    {
        return _products;
    }

    public Product GetProductById(int productId)
    {
        return _products.Find(p => p.Id == productId)!;
    }

    public void ModifyProduct(int productIdToModify, Product product)
    {
        Product toModify = GetProductById(productIdToModify);
        if (toModify is not null)
        {
            toModify.Name = product.Name;
            toModify.PromotedUntil = product.PromotedUntil;
            toModify.Category = product.Category;
            toModify.Ingredients.Clear();
            foreach (Ingredient ingredient in product.Ingredients) toModify.Ingredients.Add(ingredient);
            toModify.Opinions.Clear();
            foreach (Opinion opinion in product.Opinions) toModify.Opinions.Add(opinion);
        }
    }
}
