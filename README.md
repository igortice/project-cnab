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
cd desafio-cnab
```

### 2️⃣ Subir os containers (Rails + PostgreSQL)
```sh
docker-compose up -d
```

---

### 🛠 Comandos úteis do Docker Compose:

#### Prepare o banco de dados
```sh
docker-compose exec web bin/rails db:prepare
```

#### Rodar system tests
```sh
docker-compose exec web bin/rails test:system
```

#### Rodar testes
```sh
docker-compose exec web rspec
```

#### Acompanhar logs
```sh
docker-compose logs -f
```

#### Acessar o container da aplicação
```sh
docker-compose exec web bash
```

#### Reiniciar os containers
```sh
docker-compose up --build
```

### Remover containers e volumes e imagens
```sh
docker-compose down -v --remove-orphans --rmi all
```
