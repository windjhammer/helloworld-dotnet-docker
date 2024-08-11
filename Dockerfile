FROM mcr.microsoft.com/dotnet/sdk:8.0.303-alpine3.20 AS build

WORKDIR /hello-world

COPY hello-world/*.csproj .
RUN dotnet restore

COPY ./hello-world/. .
RUN dotnet publish -c release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/runtime:8.0
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "hello-world.dll"]
