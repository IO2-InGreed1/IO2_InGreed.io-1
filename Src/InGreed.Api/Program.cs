using InGreed.Api.Mappers;
using InGreed.DataAccess;
using InGreed.DataAccess.FakeDA;
using InGreed.DataAccess.Interfaces;
using InGreed.Logic;
using InGreed.Logic.Interfaces;
using InGreed.Logic.Mappers;
using InGreed.Logic.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddDataAccess();
builder.Services.AddLogic();
builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddScoped<IUserDA, FakeUserDA>();
builder.Services.AddScoped<IIngredientDA, FakeIngredientDA>();
builder.Services.AddScoped<IProductDA, FakeProductDA>();

builder.Services.AddScoped<IAccountService, AccountService>();
builder.Services.AddScoped<IIngredientService, IngredientService>();
builder.Services.AddScoped<IProductService, ProductService>();
builder.Services.AddScoped<ITokenService, FakeTokenService>();

builder.Services.AddScoped<IIngredientDBtoServiceResponseMapper, IngredientDBtoServiceResponseMapper>();
builder.Services.AddScoped<IContractsToModelsMapper, ContractsToModelsMapper>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
   
}
// TODO: move to IsDevelopment after presentation
app.UseSwagger();
app.UseSwaggerUI();

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
