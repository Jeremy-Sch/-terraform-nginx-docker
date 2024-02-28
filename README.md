# Terraform Docker Web App

Ce projet Terraform permet de déployer des conteneurs Docker Nginx avec une configuration flexible. Par défaut, chaque conteneur affiche le nom d'hôte sur la page d'accueil du serveur Nginx.

## Configuration

Le fichier `main.tf` contient la configuration principale. Vous pouvez personnaliser les paramètres en ajustant les variables dans ce fichier.

### Variables
- `is_remote`: Indique si l'utilisation d'un hôte Docker distant via SSH est activée (par défaut: false)
  - `remote_docker`: Adresse IP du serveur Docker
  - `ssh_user`: Utilisateur pour la connexion SSH
  - `ssh_private_key_path`: Chemin vers le fichier contenant la clé privée pour l'authentification SSH
- `container_name`: Nom du conteneur (par défaut: "web-app").
- `container_image`: Image Docker à utiliser (par défaut: "nginx").
- `containers_number`: Nombre de conteneurs à créer (par défaut: 2).
- `int_port`: Port interne pour le conteneur (par défaut: 80).
- `ext_port`: Port externe de départ pour les conteneurs (par défaut: 3000).
- `container_network`: Réseau pour le conteneur (par défaut: "web_network").
- `container_volume`: Volume pour le conteneur (par défaut: "web_data").
- `container_memory`: Mémoire allouée pour le conteneur (par défaut: 256).
- `container_restart`: Politique de redémarrage du conteneur (par défaut: "unless-stopped").
- `container_puid`: PUID pour le conteneur (par défaut: 1000).
- `container_pgid`: PGID pour le conteneur (par défaut: 1000).
- `container_tz`: Fuseau horaire pour le conteneur (par défaut: "Europe/Paris").
- `container_privileged`: Exécuter le conteneur en mode privilégié ou non (par défaut: false).
- `healthcheck_command`: Commande de healthcheck (par défaut: ["CMD", "curl", "-f", "localhost"]).

## Utilisation

1. Clonez ce dépôt Git localement :
```bash
git clone https://github.com/Jeremy-Sch/terraform-nginx-docker.git
```
```bash
cd terraform-nginx-docker
```
2. Initialisez Terraform :
```bash
terraform init
```
3. Exécutez Terraform pour créer les ressources
```bash
terraform apply
```
