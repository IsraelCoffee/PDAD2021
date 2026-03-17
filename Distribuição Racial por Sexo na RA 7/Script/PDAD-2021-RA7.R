library(survey)   # Pacote para trabalhar com amostras complexas (usado na PDAD)
library(srvyr)    # Versão "tidy" do survey – facilita uso com dplyr
library(sidrar)   # Para baixar dados do SIDRA/IBGE (não usado neste script)
library(dplyr)    # Manipulação de dados no estilo "pipe" (%>%)
library(tidyverse)# Conjunto de pacotes para ciência de dados (inclui ggplot2, dplyr, etc.)
library(ggplot2)  # Criação de gráficos
library(scales)

# Reduzindo o nome do objeto

# tabela de frequência ---------------

mor <- PDAD_2021.Moradores
rm(PDAD_2021.Moradores)

a <- mor %>%
  filter(A01ra == 7) %>%
  group_by(A01ra,
           E04, 
           E06) %>%
  rename(ra = A01ra,
         sexo = E04,
         raca = E06) %>%
  summarise(freq = n()) %>%
  mutate(porc = round(prop.table(freq) * 100, digits = 2))

tab1 <- a

rm(a)

# Mutete pode mudar uma coluna já existente ------------
# Altera os nomes da tabela de 'numericos' para 'caracteres'

# coluna 'sexo'
tab1 <- tab1 %>%
  mutate(sexo = case_when(
    sexo == 1 ~ "masculino",
    sexo == 2 ~ "feminino",
  )) %>%
# coluna 'raca'  
  mutate(raca = case_when(
    raca == 1 ~ "branca",
    raca == 2 ~ "preta",
    raca == 3 ~ "amarela",
    raca == 4 ~ "parda",
    raca == 5 ~ "indigena"
  ))

# graficos ------------

grafico1 <- tab1 %>% 
  filter(sexo == "masculino") %>%
  ggplot(aes(x = porc, y = raca)) +
  geom_col(fill = "#0F52BA", width = 0.7) +
  labs(
    title = "Masculina",
    y = NULL,
    x = "Porcentagem",
    caption = "fonte: IPEDF/PDAD-2021"
  ) +
  theme_classic()

print(grafico1)

grafico2 <- tab1 %>% 
  filter(sexo == "feminino") %>%
  ggplot(aes(x = porc, y = raca)) +
  geom_col(fill = "#ff7ea7", width = 0.7) +
  labs(
    title = "Feminina",
    y = NULL,
    x = "Porcentagem",
    caption = "fonte: IPEDF/PDAD-2021"
  ) +
  theme_classic()

print(grafico2)