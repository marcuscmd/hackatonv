﻿using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.OpenApi;
using UnifieldTech.Data;
using UnifieldTech.Models;

namespace UnifieldTech.Endpoints;

public static class FazendaEndpoints
{
    public static void MapFazendaEndpoints(this IEndpointRouteBuilder routes)
    {
        var group = routes.MapGroup("/api/Fazenda").WithTags(nameof(Fazenda));

        group.MapGet("/", async (UnifieldTechContext db) =>
        {
            return await db.Fazenda.ToListAsync();
        })
        .WithName("GetAllFazendas")
        .WithOpenApi();

        group.MapGet("/{id}", async Task<Results<Ok<Fazenda>, NotFound>> (int fazendaid, UnifieldTechContext db) =>
        {
            return await db.Fazenda.AsNoTracking()
                .FirstOrDefaultAsync(model => model.FazendaID == fazendaid)
                is Fazenda model
                    ? TypedResults.Ok(model)
                    : TypedResults.NotFound();
        })
        .WithName("GetFazendaById")
        .WithOpenApi();

        group.MapPut("/{id}", async Task<Results<Ok, NotFound>> (int fazendaid, Fazenda fazenda, UnifieldTechContext db) =>
        {
            var affected = await db.Fazenda
                .Where(model => model.FazendaID == fazendaid)
                .ExecuteUpdateAsync(setters => setters
                  .SetProperty(m => m.FazendaID, fazenda.FazendaID)
                  .SetProperty(m => m.NomeFazenda, fazenda.NomeFazenda)
                  .SetProperty(m => m.Hectar, fazenda.Hectar)
                  .SetProperty(m => m.Cultivar, fazenda.Cultivar)
                  .SetProperty(m => m.Rua, fazenda.Rua)
                  .SetProperty(m => m.Num, fazenda.Num)
                  .SetProperty(m => m.Cidade, fazenda.Cidade)
                  .SetProperty(m => m.Estado, fazenda.Estado)
                  .SetProperty(m => m.Latitude, fazenda.Latitude)
                  .SetProperty(m => m.Longitude, fazenda.Longitude)
                  .SetProperty(m => m.TipoPlantio, fazenda.TipoPlantio)
                  .SetProperty(m => m.AreaMecanizada, fazenda.AreaMecanizada)
                  .SetProperty(m => m.ClienteID, fazenda.ClienteID)
                );

            return affected == 1 ? TypedResults.Ok() : TypedResults.NotFound();
        })
        .WithName("UpdateFazenda")
        .WithOpenApi();

        group.MapPost("/", async (Fazenda fazenda, UnifieldTechContext db) =>
        {
            db.Fazenda.Add(fazenda);
            await db.SaveChangesAsync();
            return TypedResults.Created($"/api/Fazenda/{fazenda.FazendaID}", fazenda);
        })
        .WithName("CreateFazenda")
        .WithOpenApi();

        group.MapDelete("/{id}", async Task<Results<Ok, NotFound>> (int fazendaid, UnifieldTechContext db) =>
        {
            var affected = await db.Fazenda
                .Where(model => model.FazendaID == fazendaid)
                .ExecuteDeleteAsync();

            return affected == 1 ? TypedResults.Ok() : TypedResults.NotFound();
        })
        .WithName("DeleteFazenda")
        .WithOpenApi();
    }
}