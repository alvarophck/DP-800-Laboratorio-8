# Comandos de PowerShell del laboratorio (Data API Builder 2.1.5, .NET SDK 10)

# Iniciar sesión en Azure para que DAB use la identidad de Microsoft Entra
az login --scope https://database.windows.net//.default

# Instalar DAB y comprobar la versión
dotnet tool install --global Microsoft.DataApiBuilder
dab --version

# Crear el proyecto y la configuración inicial
cd $HOME\Documents
mkdir product-catalog-api
cd product-catalog-api
dab init --database-type mssql --connection-string "@env('DATABASE_CONNECTION_STRING')" --host-mode development

# Entidades, permisos, mapeos y relaciones
dab add Category --source dbo.Categories --permissions "anonymous:read"
dab add Product --source dbo.Products --permissions "anonymous:read"
dab update Product --permissions "authenticated:*"
dab update Product --map "ProductID:id,ProductName:name,UnitPrice:price,UnitsInStock:stockQuantity,Discontinued:isDiscontinued"
dab update Product --relationship category --target.entity Category --cardinality one --relationship.fields "CategoryID:CategoryID"
dab update Category --relationship products --target.entity Product --cardinality many --relationship.fields "CategoryID:CategoryID"
dab add ProductCatalog --source dbo.ProductCatalogView --source.type view --source.key-fields "ProductID" --permissions "anonymous:read"

# Cadena de conexión (autenticación de Microsoft Entra, sin contraseña) y arranque
$env:DATABASE_CONNECTION_STRING="Server=rg-sqlailab.database.windows.net;Database=ProductCatalog;Authentication=Active Directory Default;TrustServerCertificate=true"
dab start
