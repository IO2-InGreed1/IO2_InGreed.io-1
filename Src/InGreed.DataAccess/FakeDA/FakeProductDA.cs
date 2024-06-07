using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Models;
using InGreed.Domain.Enums;
using InGreed.Domain.Queries;

namespace InGreed.DataAccess.FakeDA;

public class FakeProductDA : IProductDA
{
    private static List<Product> _products = new()
    {
        new() {Id = 1, Name = "Fermented Spider Eye", PromotedUntil = new(2137, 3, 26), Category = Category.Other,
        IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/8/85/Fermented_Spider_Eye_JE2_BE2.png", ProducentId = 5 },
        new() {Id = 2, Name = "Chorus Fruit", PromotedUntil = null, Category = Category.Food,
        IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/3/33/Chorus_Fruit_JE2_BE2.png", ProducentId = 5 },
        new() {Id = 3, Name = "Potion of Fire Resistance", PromotedUntil = null, Category = Category.Drinks,
        IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/e/ee/Potion_of_Fire_Resistance_JE3.png", ProducentId = 3 }
    };
    private static int currentId = 3;

    public int CreateProduct(Product product)
    {
        product.Id = ++currentId;
        _products.Add(product);
        return currentId;
    }

    public IEnumerable<Product> GetAll(PaginationParameters paginationParameters)
    {
        return _products
            .Skip((paginationParameters.PageNumber - 1) * paginationParameters.PageSize)
            .Take(paginationParameters.PageSize); ;
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
