﻿using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.OpenApi;
using UnifieldTech.Data;
using UnifieldTech.Models;
using Twilio.Types;
using Twilio;
using Twilio.Rest.Api.V2010.Account;
using System.Net.Mail;
using System.Net;
using System.Text.Json;
namespace UnifieldTech.Endpoints;

public static class ClienteEndpoints
{
    public static void MapClienteEndpoints(this IEndpointRouteBuilder routes)
    {
        var group = routes.MapGroup("/api/Cliente").WithTags(nameof(Cliente));

        group.MapGet("/", async (UnifieldTechContext db) =>
        {
            return await db.Cliente.ToListAsync();
        })
        .WithName("GetAllClientes")
        .WithOpenApi();
        group.MapGet("/{id}", async Task<Results<Ok<Cliente>, NotFound>> (int clienteid, UnifieldTechContext db) =>
        {
            return await db.Cliente.AsNoTracking()
                .FirstOrDefaultAsync(model => model.ClienteID == clienteid)
                is Cliente model
                    ? TypedResults.Ok(model)
                    : TypedResults.NotFound();
        })
        .WithName("GetClienteById")
        .WithOpenApi();

        group.MapPut("/{id}", async Task<Results<Ok, NotFound>> (int clienteid, Cliente cliente, UnifieldTechContext db) =>
        {
            var affected = await db.Cliente
                .Where(model => model.ClienteID == clienteid)
                .ExecuteUpdateAsync(setters => setters
                  .SetProperty(m => m.ClienteID, cliente.ClienteID)
                  .SetProperty(m => m.NomeCliente, cliente.NomeCliente)
                  .SetProperty(m => m.CPF, cliente.CPF)
                  .SetProperty(m => m.E_Mail, cliente.E_Mail)
                  .SetProperty(m => m.DataNacs, cliente.DataNacs)
                  .SetProperty(m => m.Password, cliente.Password)
                  .SetProperty(m => m.Codigo, cliente.Codigo)
                );

            return affected == 1 ? TypedResults.Ok() : TypedResults.NotFound();
        })
        .WithName("UpdateCliente")
        .WithOpenApi();

        
        group.MapPost("/", async (HttpRequest request, HttpResponse response, Cliente cliente, UnifieldTechContext db) =>
        {
            // Validar o CPF antes de adicionar o cliente
            if (!ValidaCPF.validaCPF(cliente.CPF))
            {
                // O CPF não é válido, você pode retornar um erro ou uma resposta indicando o problema
                response.StatusCode = (int)HttpStatusCode.BadRequest;
                await response.WriteAsync("CPF inválido");
                return;
            }
            
            cliente.Codigo = cliente.GerarStringAleatoria();
            db.Cliente.Add(cliente);
            await db.SaveChangesAsync();
            response.StatusCode = (int)HttpStatusCode.Created;
            await response.WriteAsync(JsonSerializer.Serialize(cliente));
           
            //return TypedResults.Created($"/api/Cliente/{cliente.ClienteID}", cliente);
            // Lógica para enviar o email
            //try
            //{
            //    // Configurações do servidor SMTP
            //    string smtpHost = "smtp.gmail.com";
            //    int smtpPort = 587;
            //    string smtpUsername = "email@gmail.com";
            //    string smtpPassword = "senha";

            //    // Configurações do email
            //    string fromEmail = "email@gmail.com";
            //    string toEmail = cliente.E_Mail;
            //    string subject = "Código de Verificação";
            //    string body = "Seu código de verificação é: " + cliente.Codigo;

            //    // Cria uma instância do cliente SMTP
            //    using (SmtpClient smtpClient = new SmtpClient(smtpHost, smtpPort))
            //    {
            //        smtpClient.EnableSsl = true;
            //        smtpClient.UseDefaultCredentials = false;
            //        smtpClient.Credentials = new NetworkCredential(smtpUsername, smtpPassword);

            //        // Cria a mensagem de email
            //        MailMessage emailMessage = new MailMessage(fromEmail, toEmail, subject, body);

            //        // Envia o email
            //        smtpClient.Send(emailMessage);

            //        Console.WriteLine("Email enviado com sucesso.");
            //    }

            //    response.StatusCode = (int)HttpStatusCode.Created;
            //    await response.WriteAsync(JsonSerializer.Serialize(cliente));
            //}
            //catch (Exception ex)
            //{
            //    response.StatusCode = (int)HttpStatusCode.InternalServerError;
            //    await response.WriteAsync("Ocorreu um erro ao enviar o email: " + ex.Message);
            //}
        })
        .WithName("CreateCliente")
        .WithOpenApi();

        group.MapDelete("/{id}", async Task<Results<Ok, NotFound>> (int clienteid, UnifieldTechContext db) =>
        {
            var affected = await db.Cliente
                .Where(model => model.ClienteID == clienteid)
                .ExecuteDeleteAsync();

            return affected == 1 ? TypedResults.Ok() : TypedResults.NotFound();
        })
        .WithName("DeleteCliente")
        .WithOpenApi();
    }
}
