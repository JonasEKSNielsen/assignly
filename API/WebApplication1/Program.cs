using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

IConfiguration Configuration = builder.Configuration;

string connectionString = Configuration.GetConnectionString("DefaultConnection") ?? Environment.GetEnvironmentVariable("DefaultConnection");

builder.Services.AddDbContext<AppDBContext>(options => options.UseMySql(connectionString, ServerVersion.AutoDetect(connectionString)));

var app = builder.Build();

// Configure the HTTP request pipeline.
app.UseSwagger();
app.UseSwaggerUI();
 

//app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
