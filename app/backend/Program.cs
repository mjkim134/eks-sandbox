var builder = WebApplication.CreateBuilder(args);

// Allow all origins for Unity mobile client and local development
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader();
    });
});

var app = builder.Build();

app.UseCors("AllowAll");

// 1. K8s Liveness/Readiness Probe
app.MapGet("/health", () => Results.Ok("Healthy"));

// 2. Version check endpoint for Unity client on app startup
app.MapGet("/api/version", () => Results.Ok(new 
{ 
    version = "1.0.0", 
    status = "OK",
    timestamp = DateTime.UtcNow
}));

app.Run();
