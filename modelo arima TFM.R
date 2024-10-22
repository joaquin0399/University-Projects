library(tidyverse)
library(dplyr)
library(ggplot2)
library(ggpubr)
library(writexl)
library(forecast)
library(tseries)

library(readxl)
Resumen_marcas <- read_excel("C:/Users/Moi/Desktop/Rioja/Trabajo Fin de Master/Punto 3 TFM/Datasets/Resumen marcas-Corregido.xlsx", 
                                       sheet = "Ventas mensuales_2015-2023#")
View(Resumen_marcas_Corregido)

View(Resumen_marcas)


#####DESCRIPCCION ESTADISTICA####
summary(Resumen_marcas)
prop.table(datos1$`Ventas Totales`)
sd(datos1$`Ventas Totales`)
var(datos1$`Ventas Totales`)


#####ANALISIS DE TENDENCIA####

#Poner en formato fecha
Resumen_marcas$Fecha <- as.Date(Resumen_marcas$Fecha)

#tendencia de ventas ALTADIS
Resumen_marcas %>%
  ggplot(aes(x=Fecha, y=`Ventas Totales`)) +
  geom_line(color = '#3393f3') +
  scale_x_date(date_breaks = "6 month", date_labels = "%b-%y") +
  labs(x="Mes", y="Ventas Mensuales", title = "Ventas de ALTADIS periodo 2015 - 2023",
       caption = "Datos: ALTADIS")

#indicamos a R que es una serie temporal
ventas_st <- ts(Resumen_marcas$`Ventas Totales`, start = c(2015,1), frequency = 12)

#descomposicion de serie de tiempo
descomposicion_ventas <- decompose(ventas_st)

#graficamos
plot(descomposicion_ventas)

#extraemos la tendencia
tendencia_ventas <- descomposicion_ventas$trend
plot(tendencia_ventas)

#grafico con tendencia lineal
Resumen_marcas %>%
  ggplot(aes(x=Fecha, y=`Ventas Totales`)) +
  geom_line(color = '#3393f3') +
  geom_smooth(method = "lm") +
  scale_x_date(date_breaks = "6 month", date_labels = "%b-%y") +
  labs(x="Mes", y="Ventas Mensuales", title = "Tendencia de ventas de ALTADIS",
       caption = "Datos: ALTADIS")

#grafico con tendencia suavizada
Resumen_marcas %>%
  ggplot(aes(x=Fecha, y=`Ventas Totales`)) +
  geom_line(color = '#3393f3') +
  geom_smooth(color = '#d10e28') +
  scale_x_date(date_breaks = "6 month", date_labels = "%b-%y") +
  labs(x="Mes", y="Ventas Mensuales", title = "Tendencia de ventas de ALTADIS",
       caption = "Datos: ALTADIS")

#otra opcion de grafico mas sencilla
plot(ventas_st, ann=FALSE)
lines(tendencia_ventas, col="red")
title(main = "Tendencia de ventas ALTADIS 2015 - 2023",
      xlab = "Años",
      ylab = "Ventas")

####PRONOSTICO#####

#1. creamos el modelo ARIMA
modelo_ventas_altadis <- auto.arima(ventas_st)

#2. vamos a predecir las ventas, como los datos son mensuales, 
#vamos a predecir los proximos 12 meses
prediccion_ventas_altadis <- forecast(modelo_ventas_altadis,12)

#3. dibujamos la prediccion
plot(prediccion_ventas_altadis)

#4. extraemos los valores de la prediccion
valores_prediccion_ventas <- prediccion_ventas_altadis$mean
valores_prediccion_ventas

#5. veamos la prediccion total del modelo
prediccion_modelo <- prediccion_ventas_altadis$fitted
prediccion_modelo

#6. graficamos los datos originales en contraste con la prediccion
plot(ventas_st, ann=FALSE)
lines(prediccion_ventas_altadis$fitted, col="green", lwd=2)
title(main = "Datos reales vs valores de la predicción", xlab = "Años", ylab = "Ventas")
legend("bottomright", c("Original", "Predicción"),
       lwd=c(1,2), col=c("black", "green"), cex = 0.8)


df_pred <- data.frame(valores_prediccion_ventas)
write_xlsx(df_pred, "valores_predic.xlsx")


#comprobar estacionariedad de la serie de tiempo
adf.test(ventas_st)


            