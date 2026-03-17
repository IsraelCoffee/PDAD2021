library(ggplot2)
library(tidyverse)
library(tidyr)
library(scales)


# Renomenado a PDAD  ---------------
dom <- PDAD_2021.Domicilios
mor <- PDAD_2021.Moradores

# Opcional
# rm(PDAD_2021.Domicilios, PDAD_2021.Moradores)

# Renomendo os nomes das RAs Moradores ------- 

b <- mor %>%
  mutate(A01ra = factor(case_when(
    A01ra==1~"Plano Piloto",
    A01ra==2~"Gama",
    A01ra==3~	"Taguatinga",
    A01ra==4~	"Brazlândia",
    A01ra==5~	"Sobradinho",
    A01ra==6~	"Planaltina",
    A01ra==7~	"Paranoá",
    A01ra==8~	"Núcleo Bandeirante",
    A01ra==9~	"Ceilândia",
    A01ra==10~	"Guará",
    A01ra==11~	"Cruzeiro",
    A01ra==12~	"Samambaia",
    A01ra==13~	"Santa Maria",
    A01ra==14~	"São Sebastião",
    A01ra==15~	"Recanto Das Emas",
    A01ra==16~	"Lago Sul",
    A01ra==17~	"Riacho Fundo",
    A01ra==18~	"Lago Norte",
    A01ra== 19~ "Candangolândia",
    A01ra== 20~	"Águas Claras",
    A01ra== 21~	"Riacho Fundo II",
    A01ra== 22~	"Sudoeste e Octogonal",
    A01ra== 23~	"Varjão",
    A01ra==  24~	"Park Way",
    A01ra== 25~	"SCIA",
  A01ra==  26~	"Sobradinho II",
  A01ra==  27~	"Jardim Botânico",
    A01ra==  28~	"Itapoã",
    A01ra== 29~	"SIA",
    A01ra==  30~	"Vicente Pires",
    A01ra== 31~	"Fercal",
    A01ra== 32~	"Sol Nascente / Pôr do Sol",
    A01ra== 33~	"Arniqueira"
  )))

# Renomendo os nomes das RAs Domicios ---------

a <- dom %>%
  mutate(A01ra = factor(case_when(
    A01ra==1~"Plano Piloto",
    A01ra==2~"Gama",
    A01ra==3~	"Taguatinga",
    A01ra==4~	"Brazlândia",
    A01ra==5~	"Sobradinho",
    A01ra==6~	"Planaltina",
    A01ra==7~	"Paranoá",
    A01ra==8~	"Núcleo Bandeirante",
    A01ra==9~	"Ceilândia",
    A01ra==10~	"Guará",
    A01ra==11~	"Cruzeiro",
    A01ra==12~	"Samambaia",
    A01ra==13~	"Santa Maria",
    A01ra==14~	"São Sebastião",
    A01ra==15~	"Recanto Das Emas",
    A01ra==16~	"Lago Sul",
    A01ra==17~	"Riacho Fundo",
    A01ra==18~	"Lago Norte",
    A01ra== 19~ "Candangolândia",
    A01ra== 20~	"Águas Claras",
    A01ra== 21~	"Riacho Fundo II",
    A01ra== 22~	"Sudoeste e Octogonal",
    A01ra== 23~	"Varjão",
    A01ra==  24~	"Park Way",
    A01ra== 25~	"SCIA",
    A01ra==  26~	"Sobradinho II",
    A01ra==  27~	"Jardim Botânico",
    A01ra==  28~	"Itapoã",
    A01ra== 29~	"SIA",
    A01ra==  30~	"Vicente Pires",
    A01ra== 31~	"Fercal",
    A01ra== 32~	"Sol Nascente / Pôr do Sol",
    A01ra== 33~	"Arniqueira"
  )))


# Sumarisando os resultados ---------

tab3 <- b %>%
  group_by(A01ra, H14_2) %>%
  rename( 
    ra = A01ra,
    pre_conconcurso = H14_2) %>%
  summarise(fi = n()) %>%
  mutate(prc = (prop.table(fi)))

# tirar os NAs

tab3 <- tab3 %>%
  mutate(pre_conconcurso = factor(case_when(
    pre_conconcurso == 1 ~ "Sim",
    pre_conconcurso == 2 ~ "Não",
    pre_conconcurso == 88888 ~	"Não sabe",
  ))) %>%
  # remove todas as linhas NA do conjunto
  drop_na()

# Graficos -------------

# todos plotados de uma vez
tab3 %>%
  ggplot(aes(x = prc, y = ra)) +
  geom_bar(stat = "identity", position = "dodge2") +
  facet_wrap(vars(pre_conconcurso)) + # separa o grafico
  labs(
    title = "Curso em andamento: preparatório para concurso",
    subtitle = "Por região administrativa",
    y = NULL,
    x = NULL,
    caption = "CODEPLAN/PDAD-2021"
  ) +
  scale_x_continuous(
    # Transforma o eixo x em porcentagem
    breaks = seq(0, 1, by = 0.30),
    labels = scales::percent_format(accuracy = 1)) +
  theme_bw()

# Filtrando por: SIM

tab3 %>%
  filter(pre_conconcurso == "Sim") %>%
  ggplot(aes(x = prc, y = ra)) +
  geom_col(stat = "identity", width = 0.7) +
  labs(
    title = "Curso em andamento: preparatório para concurso",
    subtitle = "Região Administrativa: filtrado por 'sim'",
    y = NULL,
    x = NULL,
    caption = "CODEPLAN/PDAD-2021"
  ) +
  scale_x_continuous(
    # Transforma o eixo x em porcentagem
    breaks = seq(0, 1, by = 0.025),
    labels = scales::percent_format(accuracy = 1)) +
  theme_bw()

# Filtrando por: NÃO

tab3 %>%
  filter(pre_conconcurso == "Não") %>%
  ggplot(aes(x = prc, y = ra)) +
  geom_col(stat = "identity", width = 0.7) +
  labs(
    title = "Curso em andamento: preparatório para concurso",
    subtitle = "Região Administrativa: filtrado por 'não'",
    y = NULL,
    x = NULL,
    caption = "CODEPLAN/PDAD-2021"
  ) +
  scale_x_continuous(
    # Transforma o eixo x em porcentagem
    breaks = seq(0, 1, by = 0.05), # quebra a sequencia da porcentagem
    labels = scales::percent_format(accuracy = 1)) +
  theme_bw()