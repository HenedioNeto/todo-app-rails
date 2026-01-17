# Dockerfile
FROM ruby:3.4.2-slim

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    npm \
    git \
    && rm -rf /var/lib/apt/lists/*

# Configurar diretório de trabalho
WORKDIR /app

# Instalar bundler
RUN gem install bundler

# Copiar Gemfile
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copiar aplicação
COPY . .

# Expor porta
EXPOSE 3000

# Comando para iniciar
CMD ["rails", "server", "-b", "0.0.0.0"]