--SET NOCOUNT ON

DROP Table dbo.Calendar

Create Table dbo.Calendar
(
    IDCal              Integer NOT NULL,
    fechaValor               Datetime    NOT NULL,
    numDiaSemana         Integer NOT NULL,
    nomDia               VarChar (10) NOT NULL,
    nomMes             VarChar (10) NOT NULL,
    semanaAno              Integer NOT NULL,
    diaJuliano               Integer NOT NULL,
    feriadoBancario        Bit     NOT NULL,
    feriadoNombre              VarChar (100) NULL,
)
ALTER TABLE dbo.Calendar ADD CONSTRAINT
    DF_Calendar_feriadoBancario DEFAULT 0 FOR feriadoBancario;

ALTER TABLE dbo.Calendar ADD CONSTRAINT
    DF_Calendar_feriadoNombre DEFAULT '' FOR feriadoNombre;

--DECLARACI�N VARIABLES DE FECHA DE INICIO Y FIN, EL PROGRAMA LLENAR� DATOS RESPECTO DE ESTAS FECHAS
Declare @StartDate  DateTime
Set @StartDate = '01/01/2010'
Declare @EndDate    DateTime
Set @EndDate   = '01/01/2030'

While @StartDate < @EndDate
Begin
    INSERT INTO dbo.Calendar 
    (
        IDCal, 
        fechaValor, 
        semanaAno,
        numDiaSemana,
        nomDia,
        nomMes,
        diaJuliano
    )
    Values 
    (
        YEAR (@StartDate) * 10000 + MONTH (@StartDate) * 100 + Day (@StartDate), --IDCal - FECHA CON FORMATO 'YYYYMMDD'
        @StartDate,                 -- fechaValor - FECHA COMO DATETIME
        DATEPART (ww, @StartDate),  -- semanaAno - SEMANA DEL A�O
        DATEPART (dw, @StartDate),  -- numDiaSemana - N�MERO D�A DE SEMANA (E.G. MARTES = 2, VIERNES = 5)
        DATENAME (dw, @StartDate),  -- nomDia - NOMBRE DEL D�A
        DATENAME (M, @StartDate),   -- nomMes - NOMBRE DEL MES
        DATEPART (dy, @StartDate)   -- diaJuliano - D�A JULIANO (1 - 365)
    )

    Set @StartDate = @StartDate + 1
End

--=========================== FDS
-- S�BADO Y DOMINGO
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Fin de semana' WHERE numDiaSemana IN (6, 7)
-- UPDATE dbo.Calendar SET feriadoBancario = 0, feriadoNombre = '' WHERE numDiaSemana IN (1) 
-- SELECT * FROM CALENDAR WHERE feriadoBancario=1

--=========================== FERIADOS BANCARIOS POR FECHA ASC
-- A�O NUEVO
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'A�o nuevo' WHERE (IDCal % 2000) IN (0101)
--Select * from calendar WHERE feriadoNombre = 'A�o nuevo'

-- VIERNES SANTO
--UPDATE dbo.Calendar SET feriadoBancario = 0, feriadoNombre = '' WHERE (IDCal % 2000) IN (0419)
--UPDATE dbo.Calendar SET feriadoBancario = 0, feriadoNombre = '' WHERE IDCal = 20180430
--2010 EN ADELANTE
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Viernes Santo' WHERE IDCal = 20100402
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Viernes Santo' WHERE IDCal = 20110422
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Viernes Santo' WHERE IDCal = 20120406
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Viernes Santo' WHERE IDCal = 20130329
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Viernes Santo' WHERE IDCal = 20140418
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Viernes Santo' WHERE IDCal = 20150403
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Viernes Santo' WHERE IDCal = 20160325
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Viernes Santo' WHERE IDCal = 20170414
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Viernes Santo' WHERE IDCal = 20180330
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Viernes Santo' WHERE IDCal = 20190419
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Viernes Santo' WHERE IDCal = 20200410
--SELECT * FROM CALENDAR WHERE feriadoNombre = 'Viernes Santo'

-- S�BADO SANTO
--UPDATE dbo.Calendar SET feriadoBancario = 0, feriadoNombre = '' WHERE (IDCal % 2000) IN (0420)
--2010 EN ADELANTE
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'S�bado Santo' WHERE IDCal = 20100402+1
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'S�bado Santo' WHERE IDCal = 20110422+1
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'S�bado Santo' WHERE IDCal = 20120406+1
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'S�bado Santo' WHERE IDCal = 20130329+1
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'S�bado Santo' WHERE IDCal = 20140418+1
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'S�bado Santo' WHERE IDCal = 20150403+1
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'S�bado Santo' WHERE IDCal = 20160325+1
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'S�bado Santo' WHERE IDCal = 20170414+1
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'S�bado Santo' WHERE IDCal = 20180330+1
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'S�bado Santo' WHERE IDCal = 20190419+1
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'S�bado Santo' WHERE IDCal = 20200410+1
--SELECT * FROM CALENDAR WHERE feriadoNombre = 'S�bado Santo'

-- D�A DEL TRABAJADOR
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'D�a del Trabajador' WHERE (IDCal % 2000) IN (0501)
--SELECT * FROM CALENDAR WHERE feriadoNombre = 'D�a del Trabajador'

-- D�A DE LAS GLORIAS NAVALES
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'D�a de las Glorias Navales' WHERE (IDCal % 2000) IN (0521)

-- SAN PEDRO Y SAN PABLO
--UPDATE dbo.Calendar SET feriadoBancario = 0, feriadoNombre = '' WHERE (IDCal % 2000) IN (0629)
--2010++ M�VILES
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'San Pedro y San Pablo' WHERE IDCal = 20100628
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'San Pedro y San Pablo' WHERE IDCal = 20110627
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'San Pedro y San Pablo' WHERE IDCal = 20120702
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'San Pedro y San Pablo' WHERE IDCal = 20130629
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'San Pedro y San Pablo' WHERE IDCal = 20140629
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'San Pedro y San Pablo' WHERE IDCal = 20150629
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'San Pedro y San Pablo' WHERE IDCal = 20160627
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'San Pedro y San Pablo' WHERE IDCal = 20170626
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'San Pedro y San Pablo' WHERE IDCal = 20180702
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'San Pedro y San Pablo' WHERE IDCal = 20190629
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'San Pedro y San Pablo' WHERE IDCal = 20200629
--SELECT * FROM CALENDAR WHERE feriadoNombre = 'San Pedro y San Pablo'

-- D�A DE LA VIRGEN DEL CARMEN
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'D�a de la Virgen del Carmen' WHERE (IDCal % 2000) IN (0716)

-- ASUNCI�N DE LA VIRGEN
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Asunci�n de la Viernes' WHERE (IDCal % 2000) IN (0815)

-- 18 DE SEPTIEMBRE
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Independencia Nacional' WHERE (IDCal % 2000) IN (0918)

-- 19 DE SEPTIEMBRE
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'D�a de las Glorias del Ej�rcito' WHERE (IDCal % 2000) IN (0919)

-- ENCUENTRO DE DOS MUNDOS / D�A DE LA RAZA
--UPDATE dbo.Calendar SET feriadoBancario = 0, feriadoNombre = '' WHERE (IDCal % 2000) IN (1012)
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Encuentro de Dos Mundos' WHERE IDCal = 20101011
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Encuentro de Dos Mundos' WHERE IDCal = 20111010
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Encuentro de Dos Mundos' WHERE IDCal = 20121015
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Encuentro de Dos Mundos' WHERE IDCal = 20131012
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Encuentro de Dos Mundos' WHERE IDCal = 20141012
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Encuentro de Dos Mundos' WHERE IDCal = 20151012
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Encuentro de Dos Mundos' WHERE IDCal = 20161010
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Encuentro de Dos Mundos' WHERE IDCal = 20171009
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Encuentro de Dos Mundos' WHERE IDCal = 20181015
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Encuentro de Dos Mundos' WHERE IDCal = 20191012
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Encuentro de Dos Mundos' WHERE IDCal = 20201012
--SELECT * FROM CALENDAR WHERE feriadoNombre = 'Encuentro de Dos Mundos'

-- D�A DE LAS IGLESIAS EVANG�LICAS Y PROTESTANTES
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'D�a de las Iglesias Evang�licas y Protestantes' WHERE (IDCal % 2000) IN (1031)

-- D�A DE TODOS LOS SANTOS
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'D�a de Todos los Santos' WHERE (IDCal % 2000) IN (1101)

-- INMACULADA CONCEPCI�N
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Inmaculada Concepci�n' WHERE (IDCal % 2000) IN (1208)

-- NAVIDAD 24
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Noche Nueva' WHERE (IDCal % 2000) IN (1224)
--SELECT * FROM CALENDAR WHERE feriadoNombre = 'Noche Nueva'

-- NAVIDAD 25
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Navidad' WHERE (IDCal % 2000) IN (1225)

-- FERIADO BANCARIO
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Feriado Bancario' WHERE (IDCal % 2000) IN (1231)

--SELECT * FROM CALENDAR
--=========================== FERIADOS ESPECIALES
-- 17 / 20 DE SEPTIEMBRE CUANDO ('Independencia Nacional','D�a de las Glorias del Ej�rcito') CAEN EN ENTRE MARTES Y JUEVES
-- OJO, NO TODOS LOS A�OS PUEDEN CONCEDER SANDWICH
--UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Sandwich Fiestas Patrias' WHERE IDCal = 20120917
--UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Sandwich Fiestas Patrias' WHERE IDCal = 20180917
--UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Sandwich Fiestas Patrias' WHERE IDCal = 20290917
--UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Sandwich Fiestas Patrias' WHERE IDCal = 20130920
--UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Sandwich Fiestas Patrias' WHERE IDCal = 20190920
--UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Sandwich Fiestas Patrias' WHERE IDCal = 20240920
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Sandwich Fiestas Patrias' WHERE (IDCal % 2000) IN (0917) AND numDiaSemana = 1
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Sandwich Fiestas Patrias' WHERE (IDCal % 2000) IN (0920) AND numDiaSemana = 5
--SELECT * FROM CALENDAR WHERE feriadoNombre='Sandwich Fiestas Patrias'
--SELECT * FROM CALENDAR WHERE feriadoNombre='Independencia Nacional' AND numDiaSemana IN (2)
--SELECT * FROM CALENDAR WHERE feriadoNombre='D�a de las Glorias del Ej�rcito' AND numDiaSemana IN (4)

-- FERIADO ESPECIAL 24 DE DICIEMBRE - EL FERIADO PUEDE SER OTORGADO POR DISTINTAS ORGANIZACIONES
UPDATE dbo.Calendar SET feriadoBancario = 1, feriadoNombre = 'Noche Buena (Especial)' WHERE (IDCal % 2000) IN (1224)
SELECT * FROM CALENDAR WHERE feriadoBancario = 1 AND FERIADONOMBRE <> 'Fin de Semana'
