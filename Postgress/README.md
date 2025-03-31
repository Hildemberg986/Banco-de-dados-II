## 📌 Como rodar

### 1️⃣ No terminal, vá até a pasta `Postgress`:
```bash
cd ~/Postgress
```
(OBS: Se já estiver na pasta Postgress não precisa)

### 2️⃣ Execute o `docker-compose`:
```bash
sudo docker-compose up -d
```
Isso iniciará o PostgreSQL e rodará o `init.sql`. 🚀

---

## 🔎 Verificando se funcionou
Para verificar se a tabela `funcionario` foi criada corretamente, use:
```bash
sudo docker exec -it meu_postgres psql -U admin -d meu_banco_postgress -c "SELECT * FROM funcionario;"
```

## Remover container 

``` bash
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
dbpostgress
```