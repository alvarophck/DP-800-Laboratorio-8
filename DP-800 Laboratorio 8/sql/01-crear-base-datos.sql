-- 01. Crear la base de datos ProductCatalog (conectado a master)
-- Se indica edición y objetivo de servicio para que sea serverless y no consuma el crédito de la suscripción.

CREATE DATABASE ProductCatalog (EDITION = 'GeneralPurpose', SERVICE_OBJECTIVE = 'GP_S_Gen5_1');
GO

-- Comprobar edición y objetivo de servicio
SELECT d.name, o.edition, o.service_objective
FROM sys.databases d
JOIN sys.database_service_objectives o ON d.database_id = o.database_id
WHERE d.name = 'ProductCatalog';
GO
