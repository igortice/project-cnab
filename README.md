# Project CNAB

Este projeto em **Ruby on Rails** para processar arquivos **CNAB**. A aplicação foi configurada para rodar em um ambiente **Dockerizado** com **PostgreSQL**.

## 📌 Pré-requisitos

Antes de iniciar o projeto, certifique-se de ter instalado em sua máquina:

- **Docker** e **Docker Compose**  
  🔗 [Instalar Docker](https://docs.docker.com/get-docker/)  
  🔗 [Instalar Docker Compose](https://docs.docker.com/compose/install/)

---

## 🚀 Como rodar o projeto

### 1️⃣ Clonar o repositório
```sh
git clone https://github.com/igortice/project-cnab.git
cd project-cnab
```

### 2️⃣ Rodar Projeto (Rails + PostgreSQL)

#### 🔹 Opção 1: Rodar em **modo daemon** (recomendado)
Se quiser rodar os containers em segundo plano (background), use:
```sh
docker-compose up -d
```
Isso iniciará os containers sem bloquear o terminal.

#### 🔹 Opção 2: Rodar em **modo interativo** (debug)
Se quiser ver os logs em tempo real diretamente no terminal:
```sh
docker-compose up
```
Para sair, pressione **CTRL + C**.

#### 🔹 Opção 3: **Reconstruir os containers** (caso tenha feito mudanças)
Se precisar **recompilar** a aplicação e reinstalar dependências:
```sh
docker-compose up --build
```
Isso é útil se houver atualizações no **Dockerfile** ou **Gemfile**.

> ⚠️ **Importante:** Após subir os containers, a aplicação estará rodando na porta **3000** (`http://localhost:3000`) e o banco de dados PostgreSQL na porta **5432**. Certifique-se de que essas portas estão livres antes de iniciar o projeto.

---

## 🛠 O que foi feito neste projeto?

Este projeto foi desenvolvido para processar e visualizar transações financeiras a partir de arquivos no formato **CNAB**. Abaixo estão os principais pontos implementados:

- **📂 Upload e Processamento de Arquivos CNAB**
  - Interface web para envio de arquivos `.txt`
  - Validação e extração de dados
  - Armazenamento das transações no banco de dados PostgreSQL
  - 📌 **URL de Upload:** [Upload de Arquivo](http://0.0.0.0:3000/uploads/new)

- **📊 Exibição e Filtros das Transações**
  - Listagem de transações por loja
  - Filtros por período e tipo de operação
  - Totalização de entradas, saídas e saldo
  - 📌 **URL de Transações:** [Visualizar Transações](http://0.0.0.0:3000/transactions)

- **🔗 API para Integração**
  - Endpoints REST para acesso às transações
  - Paginação e filtros via query params
  - Documentação automatizada com **Swagger (RSwag)**
  - 📌 **URL da API:** [Swagger API Docs](http://0.0.0.0:3000/api-docs/index.html)

- **🛠 Testes Automatizados**
  - **RSpec** para testes de unidade e integração
  - **System Tests** para simulação de fluxo completo na UI
  - **Cobertura de código** e validação de regras de negócio

- **🐳 Ambiente Dockerizado**
  - Containers para Rails, PostgreSQL e Selenium
  - Configuração via **Docker Compose**
  - Execução dos testes dentro do ambiente Docker

🔗 **Acesse a Home do Projeto:** [Home](http://0.0.0.0:3000/)

---

## 🛠 Testes Automatizados

Este projeto possui um conjunto robusto de testes para garantir a qualidade e estabilidade da aplicação.

- **📌 Testes de Unidade e Integração**
  - Utilizamos **RSpec** para validar as regras de negócio e integração entre os componentes.
  - Para rodar os testes unitários e de integração, utilize:
    ```sh
    RAILS_ENV=test bundle exec rspec
    ```

- **📌 Testes de Sistema (UI)**
  - Simulamos interações reais do usuário com **System Tests**.
  - Para executar os testes de sistema:
    ```sh
    RAILS_ENV=test bundle exec rake test:system
    ```

- **📌 Testes Completos**
  - Caso queira rodar todos os testes do projeto (Minitest + RSpec + System Tests):
    ```sh
    RAILS_ENV=test bundle exec rails test && RAILS_ENV=test bundle exec rspec && RAILS_ENV=test bundle exec rake test:system
    ```

---

## 📂 Estrutura do Projeto

A estrutura do projeto foi organizada para manter o código limpo, modular e escalável. Abaixo, explicamos as principais pastas e seus respectivos papéis:

### 🔹 **Controllers (app/controllers/)**
Os controllers são responsáveis por receber as requisições HTTP e interagir com os models e services para processar os dados.

- **`transactions_controller.rb`** → Gerencia a listagem de transações filtradas por loja e período.
- **`uploads_controller.rb`** → Responsável pelo upload dos arquivos CNAB e a chamada para processamento.
- **`home_controller.rb`** → Renderiza a página inicial e gerencia a navegação entre as telas.

Dentro da pasta `api/`, foram criados controllers para disponibilizar endpoints REST para consumo externo:

- **`api/transactions_controller.rb`** → Fornece uma API paginada para acessar as transações.
- **`api/uploads_controller.rb`** → Endpoint para envio de arquivos via API.

---

### 🔹 **Models (app/models/)**
Os models são responsáveis pela definição da estrutura dos dados e suas relações.

- **`transaction.rb`** → Define a entidade de transação e suas validações.
- **`store.rb`** → Representa as lojas e suas transações associadas.

---

### 🔹 **Serializers (app/serializers/)**
Para estruturar as respostas da API, foram utilizados **serializers**, garantindo um formato padronizado e otimizado:

- **`transaction_serializer.rb`** → Define quais atributos de transação serão retornados na API.
- **`store_serializer.rb`** → Serializa informações da loja e suas transações associadas.

---

### 🔹 **Services (app/services/)**
Os services encapsulam a lógica de negócio, deixando os controllers mais enxutos.

- **`cnab_parser.rb`** → Responsável por interpretar e extrair os dados do arquivo CNAB.
- **`cnab_processor.rb`** → Orquestra a validação e importação das transações.
- **`cnab_validator.rb`** → Aplica regras para validar cada linha do arquivo CNAB.
- **`transaction_importer.rb`** → Realiza a inserção das transações no banco de dados, garantindo que não haja duplicações.

---

## 🔗 **Principais Funcionalidades**
✅ **Upload e processamento de arquivos CNAB** (via Web e API)  
✅ **Validação e armazenamento das transações**  
✅ **Exibição e filtragem das transações por loja e data**  
✅ **Documentação da API com Swagger**  
✅ **Paginação e organização dos endpoints**  
✅ **Testes automatizados com RSpec e System Tests**  
