#!/usr/bin/env python
# coding: utf-8

# In[3]:


import pandas as pd

# Cargar el DataFrame
df = pd.read_csv("https://raw.githubusercontent.com/jgomezcuadrado/datasets/master/titanic/train.csv")

# 1. Mostrar las primeras 5 filas
print(df.iloc[0:5])

# 2. Filtrar solo a los pasajeros que sobrevivieron
print(df.loc[df.Survived==1])

# 3. Filtrar pasajeros que no sobrevivieron y eran menores de 10 años
print(df.loc[(df.Survived==0) & (df.Age<10)])

# 4. Crear un nuevo DataFrame solo con las columnas 'Name' y 'Age'
df_name_age=df.loc[:,["Name","Age"]]
print(df_name_age)

# 5. Ordenar el DataFrame por edad de forma descendente
print(df.sort_values(by="Age",ascending=False))

# 6. Contar cuántos hombres y mujeres había en el Titanic
print(df.groupby(by="Sex").size())

# 7. Calcular la media de edad de los pasajeros
mean=df.Age.mean()
print(mean)

# 8. Rellenar valores nulos en la columna 'Age' con la media de edad
df_nonull_age=df.Age.fillna(mean)
print(df_nonull_age.describe())
print(df_nonull_age)

# 9. Crear una columna nueva que categorice a los pasajeros como 'Child', 'Adult', o 'Elderly'
df["Tipo"]=""
df.loc[(df.Age>0) & (df.Age<25),"Tipo"]="Child"
df.loc[(df.Age>25) & (df.Age<60),"Tipo"]="Adult"
df.loc[(df.Age>60),"Tipo"]="Elder"
print(df.loc[df.Tipo=="Elder"])

# 10. Concatenar dos DataFrames (por ejemplo, los 5 primeros y 5 últimos registros)
primeros5_registros=df.iloc[:5,:]
ultimos_5_registros=df.iloc[-5:,:]
print(pd.concat([primeros5_registros,ultimos_5_registros]))

# 11. Agrupar por 'Pclass' y calcular la media de edad
print(df[df.Pclass==3].mean())
print(df[df.Pclass==2].mean())
print(df[df.Pclass==1].mean())

# 12. Contar cuántos sobrevivientes había por género
sobrevivientes=df[df.Survived==1]
sobrevivientes_hombres=sobrevivientes[sobrevivientes.Sex=="male"]
sobrevivientes_mujeres=sobrevivientes[sobrevivientes.Sex=="female"]
print(sobrevivientes_hombres)
print(sobrevivientes_mujeres)

# 13. Calcular el ratio de supervivencia general
no_sobrevivientes=df[df.Survived==0]
#No sobrevivientes 549
print(no_sobrevivientes.count())
#Sobrevivientes 342
print(sobrevivientes.count())
ratio=(342/891)*100
print(ratio)

# 14. Calcular el ratio de supervivencia por género
#Sobrevivientes hombres: 109
print(sobrevivientes_hombres.count())
#Sobrevivientes mujeres: 233
print(sobrevivientes_mujeres.count())
ratio_hombres=(109/891)*100
print(ratio_hombres)
ratio_mujeres=(233/891)*100
print(ratio_mujeres)

# 15. Resetear el índice del DataFrame
print(df)

# 16. Filtrar a los pasajeros que viajaban en primera clase y sobrevivieron
print(df.pivot_table(index="Pclass",columns="Survived",values="Age",aggfunc="count",fill_value=0))

# 17. Agrupar por 'Sex' y 'Pclass' y contar cuántos había de cada combinación
print(df.pivot_table(index="Sex",columns="Pclass",values="Age",aggfunc="count",fill_value=0))

# 18. Renombrar columnas
df2 = df.rename(columns={"Age": "Edad"})
print(df2)

# 19. Eliminar la columna 'Cabin' del DataFrame
print(df.drop(["Cabin"], axis=1))

# 20. Filtrar pasajeros que tienen más de 30 años o viajaban en tercera clase
pasajeros_mayores_a_30 = df[(df.Age > 30) | (df.Pclass == 3)] 
print(pasajeros_mayores_a_30)


# In[ ]:




