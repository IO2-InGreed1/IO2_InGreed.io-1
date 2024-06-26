﻿using InGreed.Domain.Enums;

namespace InGreed.Domain.Models;

public class Preference
{
    public int Id { get; set; }
    public int OwnerId { get; set; }
    public string Name { get; set; } = string.Empty;
    public HashSet<Ingredient> Forbidden { get; set; } = new();
    public HashSet<Ingredient> Preferred { get; set; } = new();
    public Category? Category { get; set; } = null;
    public bool Active { get; set; } = new();
}
