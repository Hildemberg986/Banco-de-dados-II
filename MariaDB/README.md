## 📌 Como rodar

### 1️⃣ No terminal, vá até a pasta `MariaDB`:
```bash
cd ~/MariaDB
```
(OBS: Se já estiver na pasta MariaDB, não precisa)
### 2️⃣ Execute o docker-compose:
```bash
sudo docker-compose up -d
```
Isso iniciará o MariaDB e rodará o init.sql. 🚀

### 🔎 Verificando se funcionou
Para verificar se a tabela funcionario foi criada corretamente, use:

```bash
sudo docker exec -it meu_mariadb mariadb -u admin -padmin meu_banco_mariadb -e "SELECT * FROM funcionario;"
```
### Remover container
Para parar o container MariaDB, use:

```bash
sudo docker-compose down -v --remove-orphans
```
## login no Adminer

### localhost:
```bash 
http://localhost:8080/
```
### Servidor 
```bash 
db
```
### Usuário
```bash 
admin
```
### Senha
```bash 
admin
```
### Base de dados
```bash 
db
```