# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Project file copy and restore
COPY backend.csproj ./
RUN dotnet restore

# Copy all files and publish
COPY . ./
RUN dotnet publish -c Release -o out

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine AS runtime
WORKDIR /app
COPY --from=build /app/out ./

EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080

# Use exec form so SIGTERM is delivered directly to the process (Graceful Shutdown)
ENTRYPOINT ["dotnet", "backend.dll"]