using InGreed.DataAccess.Interfaces;
using InGreed.Domain.Models;
using InGreed.Domain.Enums;
using InGreed.Domain.Queries;
using InGreed.Domain.Helpers;
using System.Xml.Linq;

namespace InGreed.DataAccess.FakeDA;

public class FakeProductDA : IProductDA
{
    private static List<Product> _products = new()
    {
        new()
        {
            Id = 1,
            Name = "Fermented Spider Eye",
            PromotedUntil = new(2137, 3, 26),
            Category = Category.Other,
            ReportCount = 0,
            IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/8/85/Fermented_Spider_Eye_JE2_BE2.png",
            ProducentId = 5,
            Description = "A fermented spider eye is a brewing ingredient.",
            Ingredients = 
            [
                new() { Id = 1, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/f/f6/Ender_Pearl_JE3_BE2.png", Name = "Ender Pearl" },
                new() { Id = 2, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/3/3f/Nether_Wart_(item)_JE2_BE1.png", Name = "Nether Wart" }
            ]
        },
        new()
        {
            Id = 2,
            Name = "Chorus Fruit",
            PromotedUntil = null,
            Category = Category.Food,
            ReportCount = 0,
            IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/3/33/Chorus_Fruit_JE2_BE2.png",
            ProducentId = 5,
            Description = "Chorus fruit is a food item native to the End that can be eaten, or smelted into popped chorus fruit. " +
            "It can be eaten even when the hunger bar is full, and eating it may teleport the player up to 8 blocks in any direction.",
            Ingredients = 
            [
                new() { Id = 2, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/3/3f/Nether_Wart_(item)_JE2_BE1.png", Name = "Nether Wart" },
                new() { Id = 3, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/b/b1/Bone_Meal_JE3_BE3.png", Name = "Bone Meal" }
            ]
        },
        new()
        {
            Id = 3,
            Name = "Potion of Fire Resistance",
            PromotedUntil = null,
            Category = Category.Drinks,
            ReportCount = 1,
            IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/e/ee/Potion_of_Fire_Resistance_JE3.png",
            ProducentId = 3,
            Description = "Fire Resistance is a status effect that grants the affected player/mob complete immunity to all sources of fire damage.",
            Ingredients = 
            [
                new() { Id = 1, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/f/f6/Ender_Pearl_JE3_BE2.png", Name = "Ender Pearl" },
                new() { Id = 3, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/b/b1/Bone_Meal_JE3_BE3.png", Name = "Bone Meal" }
            ]
        },
        new()
        {
            Id = 4,
            Name = "Enchanted Golden Apple",
            PromotedUntil = null,
            Category = Category.Food,
            ReportCount = 1,
            IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/e/ed/Enchanted_Golden_Apple_JE2_BE2.gif",
            ProducentId = 5,
            Description = "An enchanted golden apple (in Java Edition), notch apple, or enchanted apple (in Bedrock Edition), is a rare, uncraftable variant of " +
            "the golden apple that grants much more powerful effects when consumed.",
            Ingredients =
            [
                new() { Id = 15, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/8/8a/Gold_Ingot_JE4_BE2.png", Name = "Gold Ingot" },
                new() { Id = 16, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/a/af/Apple_JE3_BE3.png", Name = "Apple" }
            ]
        },
        new()
        {
            Id = 5,
            Name = "Honey Bottle",
            PromotedUntil = null,
            Category = Category.Cosmetics,
            ReportCount = 0,
            IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/c/c2/Honey_Bottle_JE1_BE2.png",
            ProducentId = 3,
            Description = "A honey bottle is a consumable drink item obtainable by using a glass bottle on a full beehive. Honey bottles remove poison when drunk " +
                "and can be used to craft honey blocks and sugar.",
            Ingredients =
            [
                new() { Id = 1, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/f/f6/Ender_Pearl_JE3_BE2.png", Name = "Ender Pearl" },
                new() { Id = 3, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/b/b1/Bone_Meal_JE3_BE3.png", Name = "Bone Meal" }
            ]
        },
        new()
        {
            Id = 6,
            Name = "Suspicious Stew",
            PromotedUntil = new(2024, 10, 10),
            Category = Category.Food,
            ReportCount = 100,
            IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/d/da/Suspicious_Stew_JE1_BE1.png",
            ProducentId = 5,
            Description = "Suspicious stew is a food item that can give the player a status effect that depends on the flower used to craft it.",
            Ingredients =
            [
                new() { Id = 1, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/f/f6/Ender_Pearl_JE3_BE2.png", Name = "Ender Pearl" },
                new() { Id = 3, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/b/b1/Bone_Meal_JE3_BE3.png", Name = "Bone Meal" }
            ]
        },
        new()
        {
            Id = 7,
            Name = "Potion of Slow Falling",
            PromotedUntil = new(2024, 10, 11),
            Category = Category.Drinks,
            ReportCount = 0,
            IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/b/b7/Potion_of_Slow_Falling_JE2_BE2.png",
            ProducentId = 5,
            Description = "Slow Falling is a status effect that causes the affected mob to fall slower and take no fall damage, but does not prevent ender pearl damage.",
            Ingredients =
            [
                new() { Id = 1, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/f/f6/Ender_Pearl_JE3_BE2.png", Name = "Ender Pearl" },
                new() { Id = 3, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/b/b1/Bone_Meal_JE3_BE3.png", Name = "Bone Meal" }
            ]
        },
        new()
        {
            Id = 8,
            Name = "Light Blue Dye",
            PromotedUntil = new(2024, 10, 12),
            Category = Category.Cosmetics,
            ReportCount = 0,
            IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/6/64/Light_Blue_Dye_JE2_BE2.png",
            ProducentId = 3,
            Description = "Light blue dye is a quasi-primary dye.",
            Ingredients =
            [
                new() { Id = 1, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/f/f6/Ender_Pearl_JE3_BE2.png", Name = "Ender Pearl" },
                new() { Id = 3, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/b/b1/Bone_Meal_JE3_BE3.png", Name = "Bone Meal" }
            ]
        },
        new()
        {
            Id = 9,
            Name = "Potion of Healing",
            PromotedUntil = null,
            Category = Category.Drinks,
            ReportCount = 0,
            IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/5/5e/Potion_of_Healing_JE2_BE2.gif",
            ProducentId = 3,
            Description = "A Potion of Healing restores health instantly when consumed.",
            Ingredients =
            [
                new() { Id = 17, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/e/e7/Water_Bottle_JE2_BE2.png", Name = "Water Bottle" },
                new() { Id = 2, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/2/2c/Nether_Wart_JE2_BE1.png", Name = "Nether Wart" },
                new() { Id = 19, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/3/36/Glistering_Melon_Slice_JE2_BE2.png", Name = "Glistering Melon" }
            ]
        },
        new()
        {
            Id = 10,
            Name = "Totem of Undying",
            PromotedUntil = null,
            Category = Category.Other,
            ReportCount = 2,
            IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/2/25/Totem_of_Undying_JE2_BE2.png",
            ProducentId = 5,
            Description = "A Totem of Undying is a rare item that can save the holder from death.",
            Ingredients =
            [
                new() { Id = 6, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/d/d6/Emerald_JE3_BE2.png", Name = "Emerald" }
            ]
        },
        new()
        {
            Id = 11,
            Name = "Eye of Ender",
            PromotedUntil = null,
            Category = Category.Cosmetics,
            ReportCount = 1,
            IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/3/32/Eye_of_Ender_JE2_BE2.png",
            ProducentId = 6,
            Description = "An Eye of Ender is an item that can be used to locate strongholds and activate End Portals.",
            Ingredients =
            [
                new() { Id = 1, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/9/9d/Ender_Pearl_JE3_BE2.png", Name = "Ender Pearl" },
                new() { Id = 25, IconURL = "https://static.wikia.nocookie.net/minecraft_gamepedia/images/7/7b/Blaze_Powder_JE2_BE2.png", Name = "Blaze Powder" }
            ]
        }
    };
    private static int currentId = 11;

    public int CreateProduct(Product product)
    {
        product.Id = ++currentId;
        _products.Add(product);
        return currentId;
    }

    public PaginatedList<ProductWithOwner> GetAll(ProductParameters parameters)
    {
        Func<Product, bool> pred = p => (parameters.Category is null || p.Category == parameters.Category)
            && (parameters.Name is null || p.Name == parameters.Name)
            && !parameters.usedIngredientsId.Except(p.Ingredients.Select(i => i.Id)).Any()
            && !parameters.bannedIngredientsId.Intersect(p.Ingredients.Select(i => i.Id)).Any();

        var products = _products
            .Where(pred)
            .Skip((parameters.PageNumber - 1) * parameters.PageSize)
            .Take(parameters.PageSize);

        var count = _products.Where(pred).Count();
        var totalPages = (int)Math.Ceiling(count / (double)parameters.PageSize);
        List<ProductWithOwner> productsWithOwners = new();
        IUserDA userDA = new FakeUserDA();
        foreach (var product in products) productsWithOwners.Add(new() { Product = product, Owner = userDA.GetUserById(product.ProducentId).Username });
        return new PaginatedList<ProductWithOwner>(productsWithOwners, parameters.PageNumber, totalPages, parameters.PageSize);
    }

    public PaginatedList<ProductWithOwner> GetReported(ProductParameters parameters)
    {
        List<Product> temp = new(_products);
        _products = _products.Where(p => p.ReportCount > 0).ToList();
        var result = GetAll(parameters);
        _products = temp;
        return result;
    }

    public ProductWithOwner GetProductById(int productId)
    {
        Product result = _products.Find(p => p.Id == productId)!;
        if (result is null) return new() { Product = null!, Owner = string.Empty };
        return new() { Product = result, Owner = new FakeUserDA().GetUserById(result.ProducentId).Username };
    }

    public void ModifyProduct(int productIdToModify, Product product)
    {
        Product toModify = GetProductById(productIdToModify).Product;
        if (toModify is not null)
        {
            toModify.Name = product.Name;
            toModify.PromotedUntil = product.PromotedUntil;
            toModify.Category = product.Category;
            toModify.Description = product.Description;
            toModify.IconURL = product.IconURL;
            toModify.Ingredients.Clear();
            foreach (Ingredient ingredient in product.Ingredients) toModify.Ingredients.Add(ingredient);
        }
    }

    public bool RemoveReports(int productId)
    {
        Product? toModify = GetProductById(productId).Product;
        if (toModify is null) return false;
        toModify.ReportCount = 0;
        return true;
    }

    public bool Report(int productId)
    {
        Product? toReport = GetProductById(productId).Product;
        if (toReport is null) return false;
        ++toReport.ReportCount;
        return true;
    }

    public bool Delete(int id)
    {
        return _products.Remove(GetProductById(id).Product);
    }
}
