# syntax = docker/dockerfile:1

# Definição da versão do Ruby
ARG RUBY_VERSION=3.2.6
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# Definir diretório de trabalho
WORKDIR /rails

# Instalar pacotes básicos para desenvolvimento
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential curl libjemalloc2 libvips postgresql-client bash \
    bash-completion libffi-dev tzdata nodejs npm gnupg libpq-dev pkg-config git && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Instalar Yarn e dependências JavaScript corretamente
RUN npm install -g yarn

# Configuração de ambiente
ENV RAILS_ENV="development" \
    BUNDLE_PATH="/usr/local/bundle"

# Criar usuário Rails não-root (UID 1000)
RUN groupadd --system --gid 1000 rails && \
    useradd -m -g rails --uid 1000 --gid 1000 rails

# Build stage para dependências
FROM base AS build

# Copiar arquivos de dependências do Ruby
COPY Gemfile Gemfile.lock ./
RUN bundle config set frozen false && bundle install --jobs 4 && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Copiar código da aplicação
COPY . .

# Instalar dependências do JavaScript (Esbuild, Tailwind)
RUN yarn install

# Ajustar permissões para evitar erro "Permission Denied"
RUN mkdir -p /rails/app/assets/builds /rails/tmp /rails/log /rails/storage && \
    chown -R rails:rails /rails/app/assets /rails/tmp /rails/log /rails/storage && \
    chmod -R u+rwx /rails/app/assets /rails/tmp /rails/log /rails/storage

# Criar usuário Rails e definir permissões
USER rails

# Entrypoint para preparar o banco de dados
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Expor porta do Rails
EXPOSE 3000

# Comando de inicialização
CMD ["bin/dev"]
