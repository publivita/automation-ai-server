
# 🚀 Docker Setup Script para Automação de Mídias Sociais com IA 🤖

Este script automatiza a instalação e configuração de ferramentas essenciais para automação de mídias sociais utilizando inteligência artificial. Ele configura contêineres Docker com tudo que você precisa para começar rapidamente!

---

## 🛠️ Recursos do Script

- ✅ Verifica se está sendo executado com permissões de administrador (root ou sudo).
- 🔄 Atualiza o sistema operacional e limpa pacotes desnecessários.
- 🐳 Instala Docker e Docker Compose.
- 🌐 Cria ou verifica a existência da rede Docker personalizada.
- 🛒 Clona ou atualiza repositórios Git.
- 📦 Instala ferramentas específicas para automação de mídias sociais com IA:
  - **MinIO**: Gerenciamento de armazenamento.
  - **Evolution API**: Integração com IA.
  - **N8N**: Automação de fluxos de trabalho.
- 📝 Registra logs detalhados para auditoria e diagnóstico.

---

## 🔑 Pré-requisitos

1. **Sistema Operacional**: Linux (Ubuntu recomendado).
2. **Acesso Root ou Sudo**: Necessário para instalar pacotes e criar redes.
3. **Git**: Para clonar repositórios.
4. **Conexão com a Internet**: Necessária para baixar pacotes e imagens Docker.

---

## 🚀 Como Usar

### 1️⃣ Clone o repositório e torne o script em executável
```bash
git clone https://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@github.com/publivita/automation-ai-server.git && cd automation-ai-server && cp install.sh ../ && cd .. && chmod +x install.sh
```

### 2️⃣ Execute o Script
Execute o script com privilégios administrativos:
```bash
sudo su
./install.sh
```

---

##  💻 Endereço IP das aplicações

Lista de IPs após subir o container do zero

| Serviço          | URL                                      |
|------------------|------------------------------------------|
| n8n              | [http://192.168.1.7:5678/setup](http://192.168.1.7:5678/setup) |
| dify_nginx_1     | [http://172.19.0.9:80/](http://172.19.0.9:80/)                 |
| portainer        | [https://172.18.0.2:9443/#!/home](https://172.18.0.2:9443/#!/home) |
| minio            | [http://192.168.1.2:9001/login](http://192.168.1.2:9001/login) |
| evolution_api    | [http://192.168.1.5:8080/manager](http://192.168.1.5:8080/manager) |

## ⚙️ O Que o Script Faz

### 🔒 Verificação de Permissões
- Certifica-se de que o script está sendo executado como `root` ou com `sudo`.

### 📦 Atualização do Sistema
- Atualiza pacotes existentes e remove pacotes obsoletos para manter o sistema otimizado.

### 🐳 Instalação do Docker
- Adiciona o repositório oficial do Docker.
- Instala o Docker e o Docker Compose.

### 🌐 Criação da Rede Docker
- Verifica se a rede `private_network` já existe.
- Se não existir, cria a rede com:
  - **Sub-rede**: `192.168.1.0/24`
  - **Gateway**: `192.168.1.1`

### 📂 Clonagem de Repositórios
- Clona ou atualiza o repositório de ferramentas para automação.

### ⚡ Execução de Contêineres
- Configura e inicia contêineres para:
  - **MinIO**: Gerenciamento de dados.
  - **Evolution API**: IA integrada.
  - **N8N**: Automação de fluxos.

### 📝 Registro de Logs
- Todas as ações são registradas em `/var/log/docker_setup.log`.

---

## ⚡ Configurações Importantes

### 🌐 Rede Docker
- **Nome**: `private_network`
- **Sub-rede**: `192.168.1.0/24`
- **Gateway**: `192.168.1.1`

### 🛠️ Ferramentas Instaladas
- **MinIO**: Gerenciamento de armazenamento para IA.
- **Evolution API**: API para integração com inteligência artificial.
- **N8N**: Automação avançada de fluxos de trabalho.

### 📂 Diretórios
- O repositório principal será clonado para `/opt/automation-ai-server`.
- Cada ferramenta possui seu próprio diretório com um arquivo `docker-compose.yml`.

---

## 🛡️ Logs e Diagnóstico
- Todos os logs são registrados no arquivo `/var/log/docker_setup.log`.
- Consulte o log para entender possíveis erros ou falhas no processo.

---

## 🆘 Troubleshooting

### Permissões
Certifique-se de executar o script com `root não como sudo`:
```bash
./install.sh
```

### Rede já existe
- O script verifica automaticamente se a rede já existe e ignora sua criação.

### Docker não instalado corretamente
Verifique manualmente a instalação com:
```bash
docker --version
docker-compose --version
```

---

## 💡 Contribuições
Sinta-se à vontade para contribuir com melhorias ou novas funcionalidades. Para isso, abra um pull request no [repositório do GitHub](https://github.com/publivita/automation-ai-server).

---

## 📝 Licença
Este projeto está licenciado sob a licença MIT. Consulte o arquivo `LICENSE` para mais detalhes.

---

## 🌟 Resultado Final
Com este script, você terá um ambiente configurado para automação de mídias sociais com IA, pronto para gerenciar e otimizar suas operações de forma eficiente! 🚀

# automation-ai-server
