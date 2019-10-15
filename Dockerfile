FROM nginx:alpine AS base

FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS publish
WORKDIR /src

COPY nginx.conf .

COPY ["SimpleStaticBlazor.csproj", ""]
RUN dotnet restore

COPY . .
RUN dotnet publish -c release -o /app

FROM base AS final
COPY --from=publish /src/nginx.conf /etc/nginx/nginx.conf
COPY --from=publish /app/SimpleStaticBlazor/dist /usr/share/nginx/html/
