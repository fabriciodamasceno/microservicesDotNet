FROM mcr.microsoft.com/dotnet/sdk:6.0.421 AS build


# Copia os arquivos do projeto e restaura as dependências
COPY . .
WORKDIR /app
RUN dotnet restore ./GeekShopping.ProductAPI/

# Compila o projeto
RUN dotnet build -c Release -o ./GeekShopping.ProductAPI/build

# Publica a aplicação
FROM build AS publish
RUN dotnet publish -c Release -o /GeekShopping.ProductAPI/publish

# Cria a imagem final do contêiner
FROM mcr.microsoft.com/dotnet/aspnet:6.0.0 AS final
WORKDIR /app/GeekShopping.ProductAPI/
COPY --from=publish /publish .
ENTRYPOINT ["dotnet", "GeekShopping.ProductAPI.dll"] 
