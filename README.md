# 📱 Pokédex App

Este aplicativo foi desenvolvido em **Flutter** com o objetivo de praticar e aprimorar minhas habilidades com **Flutter** e no consumo de **APIs REST**.

A aplicação consome dados da [PokéAPI](https://pokeapi.co/api/v2/pokemon/) e permite que o usuário pesquise um Pokémon pelo nome, exibindo informações como:

- Nome
- Altura
- Peso
- Habilidades
- Outros atributos relevantes

---

## ✨ Funcionalidades

🔍 **Busca de Pokémon por nome**

📋 **Exibição de informações detalhadas:**
- Nome
- Altura
- Peso
- Habilidades
- Experiência base
- Tipo(s)

---

## 🔗 API Utilizada

- [PokéAPI - https://pokeapi.co/api/v2/pokemon/](https://pokeapi.co/api/v2/pokemon/)

---

## 🛠️ Tecnologias

- Flutter
- Dart
- Biblioteca `http` (requisições HTTP)

---

## ▶️ Exemplo de Uso

O usuário digita o nome de um Pokémon (ex: `pikachu`) e o app retorna:

Nome: Pikachu

Altura: 4

Peso: 60

Habilidades: static, lightning-rod

Ataques: mega-punch, pay-day, thunder-punch, slam, double-kick

*(Esses dados são obtidos em tempo real da API.)*

---

## 📸 Capturas de Tela

### 🔎 Tela de Pesquisa

![Tela de Pesquisa](imgs/Captura%20de%20tela%20de%202025-04-24%2012-33-36.png)

### 📋 Resultado da Busca

![Resultado do Pokémon](imgs/Captura%20de%20tela%20de%202025-04-24%2012-07-31.png)

---

## 🚀 Como Rodar o Projeto

```bash
git clone https://github.com/gustavodovale/Pokedex_App.git
cd Pokedex_App
flutter pub get
flutter run