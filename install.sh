#!/bin/bash

set -euo pipefail

NETWORK_NAME="private_network"
SUBNET="192.168.1.0/24"
GATEWAY="192.168.1.1"
GITHUB_REPO="https://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@github.com/publivita/automation-ai-server.git"
WORK_DIR="/opt/automation-ai-server"
LOG_FILE="/var/log/docker_setup.log"

# Função para exibir mensagens
log() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $*" | tee -a "$LOG_FILE"
}

# Verifica se está sendo executado como root
if [[ $EUID -ne 0 ]]; then
  log "Erro: Este script deve ser executado como root ou com sudo."
  exit 1
fi

log "Iniciando configuração do sistema."

# Atualização e upgrade do sistema
log "Atualizando pacotes do sistema..."
apt-get update && apt-get upgrade -y

# Instalando dependências básicas
log "Instalando dependências..."
apt-get install -y ca-certificates curl git

# Adicionando chave GPG e repositório Docker
log "Adicionando chave GPG e repositório Docker..."
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Instalando Docker e Docker Compose
log "Instalando Docker e Docker Compose..."
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose

log "Verificando instalação do Docker..."
if ! docker --version >/dev/null 2>&1; then
  log "Erro: Docker não foi instalado corretamente."
  exit 1
fi

# Criando rede Docker
log "Verificando a existência da rede Docker $NETWORK_NAME..."
if ! docker network inspect "$NETWORK_NAME" >/dev/null 2>&1; then
  log "Rede $NETWORK_NAME não encontrada. Criando..."
  docker network create \
    --driver bridge \
    --subnet="$SUBNET" \
    --gateway="$GATEWAY" \
    "$NETWORK_NAME"
  log "Rede $NETWORK_NAME criada com sucesso."
else
  log "Rede $NETWORK_NAME já existe. Ignorando criação."
fi

# Clonando repositório do GitHub
log "Clonando repositório do GitHub..."
if [[ ! -d "$WORK_DIR" ]]; then
  git clone "$GITHUB_REPO" "$WORK_DIR"
else
  log "Diretório $WORK_DIR já existe. Atualizando repositório..."
  git -C "$WORK_DIR" pull
fi

# Instalando os contêineres
log "Instalando contêineres..."
cd "$WORK_DIR"

for service in portainer minio evolution-api n8n dify; do
  log "Subindo contêiner $service..."
  if [[ -d "$service" ]]; then
    cd "$service"
    docker-compose up -d || { log "Erro ao subir o contêiner $service."; exit 1; }
    cd ..
  else
    log "Diretório $service não encontrado. Pulando..."
  fi
done

# Limpeza do sistema
log "Removendo pacotes desnecessários..."
apt-get autoremove -y && apt-get clean

log "Configuração concluída com sucesso!"

declare -A services=(["portainer"]="https://{{IP}}:9443/#\\!/home" ["evolution_api"]="http://{{IP}}:8080/manager" ["minio"]="http://{{IP}}:9001/login" ["dify_nginx_1"]="http://{{IP}}:80/" ["n8n"]="http://{{IP}}:5678/setup"); for container in "${!services[@]}"; do IP=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$container" 2>/dev/null); if [[ -n $IP ]]; then echo "${container}: ${services[$container]//\{\{IP\}\}/$IP}"; else echo "${container}: Contêiner não encontrado ou sem IP configurado."; fi; done
