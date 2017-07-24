<Project Sdk="Microsoft.NET.Sdk.Web">
  <PropertyGroup>
    <TargetFramework>netcoreapp1.0</TargetFramework>
  </PropertyGroup>
  <ItemGroup>
    <Folder Include="wwwroot\" />
  </ItemGroup>
  <ItemGroup>
    <PackageReference Include="Microsoft.AspNetCore" Version="1.0.4" />
    <PackageReference Include="Microsoft.AspNetCore.Mvc" Version="1.0.3" />
    <PackageReference Include="Microsoft.EntityFrameworkCore.Design" Version="1.1.2" />
    <PackageReference Include="Microsoft.EntityFrameworkCore.Sqlite" Version="1.1.2" />
    <PackageReference Include="Microsoft.EntityFrameworkCore.Tools.DotNet" Version="1.0.1" />
    <PackageReference Include="Microsoft.Extensions.Configuration.EnvironmentVariables" Version="1.1.2" />
    <PackageReference Include="Microsoft.Extensions.Logging.Debug" Version="1.0.2" />
  </ItemGroup>

  <ItemGroup>
    <DotNetCliToolReference Include="Microsoft.EntityFrameworkCore.Tools.DotNet" Version="1.0.1" />
  </ItemGroup>

</Project>