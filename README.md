# PDAD2021

# Distribuição Racial por Sexo na RA 7 – PDAD 2021

Visualização da composição racial (autodeclarada) da população residente na **Região Administrativa 7** (RA 7) do Distrito Federal, separada por sexo (masculino e feminino).

Dados extraídos da **Pesquisa Distrital por Amostra de Domicílios (PDAD) 2021** – IPEDF.

<p align="center">
  <img src="https://via.placeholder.com/800x400/0F52BA/FFFFFF?text=Masculino" alt="Gráfico Masculino" width="45%">
  <img src="https://via.placeholder.com/800x400/ff7ea7/FFFFFF?text=Feminino" alt="Gráfico Feminino" width="45%">
</p>

*(Substitua as URLs acima pelos caminhos reais das imagens no repositório após commit: `./grafico_masculino.png` e `./grafico_feminino.png`)*

## O que o código faz?

- Filtra apenas os moradores da **RA 7** (A01ra == 7)
- Calcula a frequência e o percentual de cada categoria de raça/cor por sexo
- Cria dois gráficos de barras horizontais (um para masculino e outro para feminino)
- Usa cores distintas para facilitar a diferenciação visual

## Principais categorias de raça/cor utilizadas (PDAD)

- Branca
- Preta
- Amarela
- Parda
- Indígena

## Resultados observados (PDAD 2021 – RA 7)

- **Parda** é, de longe, a categoria mais frequente tanto no sexo masculino (~55–60%) quanto no feminino (~55–60%).
- A população **branca** aparece em segundo lugar (~25–30%).
- **Preta**, **amarela** e **indígena** têm participações bem menores.

## Estrutura do repositório

```text
.
├── PDAD-2021-RA7.R         # Script principal em R

├── README.md               # Esta documentação

├── grafico_masculino.png   # (gerado pelo script – opcional commitar)

└── grafico_feminino.png    # (gerado pelo script – opcional commitar)
