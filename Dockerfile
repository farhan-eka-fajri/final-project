#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443
EXPOSE 48719
EXPOSE 27017
EXPOSE 5000
EXPOSE 5001


FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY . .

#COPY ["TodoAppTest/TodoAppTest.csproj", "TodoAppTest/"]
#RUN dotnet restore "TodoAppTest/TodoAppTest.csproj"
#COPY . .
#WORKDIR "/src/TodoAppTest"
#RUN dotnet build "TodoAppTest.csproj" -c Release -o /app/build

RUN dotnet restore 
RUN dotnet build --no-restore -c Release -o /app

FROM build AS publish
RUN dotnet publish "TodoApp.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
#COPY --from=publish /app/publish .
COPY --from=publish /app/ .
#ENTRYPOINT ["dotnet", "TodoAppTest.dll"]
CMD ASPNETCORE_URLS=http://*:$PORT dotnet PaymentApi.dll