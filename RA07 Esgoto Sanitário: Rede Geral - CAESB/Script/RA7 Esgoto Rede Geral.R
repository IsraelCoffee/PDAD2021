library(survey)   # Pacote para trabalhar com amostras complexas (usado na PDAD)
library(srvyr)    # Versão "tidy" do survey – facilita uso com dplyr
library(sidrar)   # Para baixar dados do SIDRA/IBGE (não usado neste script)
library(dplyr)    # Manipulação de dados no estilo "pipe" (%>%)
library(tidyverse)# Conjunto de pacotes para ciência de dados (inclui ggplot2, dplyr, etc.)
library(ggplot2)  # Criação de gráficos
library(scales)
library(readr)

PDAD_2021_Domicilios <- read_delim("C:/Users/VD11740/Downloads/PDAD/2021/PDAD_2021-Domicilios.csv", 
                                   delim = ";", escape_double = FALSE, trim_ws = TRUE)
View(PDAD_2021_Domicilios)

dom <- PDAD_2021_Domicilios

a <- dom

# tabela de frequencia ----------
tab1 <- a %>%
  group_by(A01ra, B14_1) %>%
  mutate(A01ra = factor(case_when(
    A01ra == 1~ "Plano Piloto",
    A01ra == 2~	"Gama",
    A01ra ==  3~	"Taguatinga",
    A01ra ==  4~	"Brazlândia",
    A01ra ==  5~	"Sobradinho",
    A01ra == 6~	"Planaltina",
    A01ra ==  7~	"Paranoá",
    A01ra == 8~	"Núcleo Bandeirante",
    A01ra == 9~	"Ceilândia",
    A01ra == 10~	"Guará",
    A01ra == 11~	"Cruzeiro",
    A01ra == 12~	"Samambaia",
    A01ra == 13~	"Santa Maria",
    A01ra == 14~	"São Sebastião",
    A01ra == 15~	"Recanto Das Emas",
    A01ra == 16~	"Lago Sul",
    A01ra ==  17~	"Riacho Fundo",
    A01ra ==  18~	"Lago Norte",
    A01ra ==  19~	"Candangolândia",
    A01ra ==  20~	"Águas Claras",
    A01ra ==  21~	"Riacho Fundo II",
    A01ra == 22~	"Sudoeste e Octogonal",
    A01ra == 23~	"Varjão",
    A01ra == 24~	"Park Way",
    A01ra == 25~	"SCIA",
    A01ra == 26~	"Sobradinho II",
    A01ra ==  27~	"Jardim Botânico",
    A01ra ==  28~	"Itapoã",
    A01ra == 29~	"SIA",
    A01ra ==   30~	"Vicente Pires",
    A01ra ==  31~	"Fercal",
    A01ra ==   32~	"Sol Nascente",
    A01ra ==  33~	"Arniqueira"))) %>%
  summarise(freq = n())%>%
  mutate(porc = round(prop.table(freq), digits = 2))


# renomeado a tabela --------

tab1 <- tab1 %>%
  rename(
    ra = A01ra,
    Es_geral = B14_1
  )

# mudando as respostas --------

tab2 <- tab1 %>%
  mutate(Es_geral = factor(case_when(
    Es_geral == 1 ~ "Sim",
    Es_geral == 2 ~ "Não",
    Es_geral == 88888 ~ "Não sabe"
  )))

# gráficos --------

# Colplot-----
tab2 %>%
  filter(ra == "Paranoá") %>%
  ggplot(aes(x = porc, y = Es_geral)) +
  # "fill" é o gradiente de cor
  geom_col(fill = c("green4", "red4")) +
  labs(title = "Esgoto Sanitário: Rede Geral - CAESB",
       subtitle = "Paranoá - RA07",
       y = NULL,
       x = "Porcentagem",
       caption = "CODEPLAN/PDAD-2021") +
  scale_x_continuous(
    # Transforma o eixo x em porcentagem
      labels = scales::percent_format(accuracy = 1)) +
  theme_bw()
  
  
# Barplot ------
tab2 %>%
  filter(ra == "Paranoá") %>%
  ggplot(aes(x = Es_geral, y = porc)) +
  # Sempre colocar: stat = "identity"
  # width: permite controlar a largura da barra.
  geom_bar(stat = "identity", width = 0.4, fill = c("green4", "red4"))+
  labs(title = "Esgoto Sanitário: Rede Geral - CAESB",
       subtitle = "Paranoá - RA07",
       y = NULL,
       x = NULL,
       caption = "CODEPLAN/PDAD-2021") +
  # Transforma o eixo y em porcentagem
  scale_y_continuous(
    breaks = seq(0, 1, by = 0.1),
    labels = scales::percent_format(accuracy = 1)) +
    theme_bw()
