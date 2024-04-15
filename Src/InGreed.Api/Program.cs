using InGreed.DataAccess;
using InGreed.Domain.Models;
using Microsoft.AspNetCore.Identity;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddIdentityApiEndpoints<User>().AddUserStore<UserFakeRepository>().AddDefaultTokenProviders();

builder.Services.AddTransient<IUserStore<User>, UserFakeRepository>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}


app.UseHttpsRedirection();

app.MapGroup("/identity").MapIdentityApi<User>();
app.UseAuthorization();

app.MapControllers();

app.Run();
