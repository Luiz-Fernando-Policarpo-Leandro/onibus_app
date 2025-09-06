# Ônibus App

## TCC

Este projeto foi desenvolvido como parte do **Trabalho de Conclusão de Curso (TCC)**.
O objetivo é abordar temas como **segurança web**, **APIs** e **autenticação**, seguindo boas práticas e buscando clareza no desenvolvimento.

## Meios de Transporte

Atualmente, um dos problemas que afetam e prejudicam os estudantes universitários — além das notas, horários e disciplinas — é o transporte. Muitos estudantes são, majoritariamente, residentes de outros municípios, e em diversos estados brasileiros há carência de transporte público. Quando ele existe, frequentemente não há espaço suficiente, o que leva muitos alunos a irem a pé para a universidade.

---

## Gems Utilizadas

* `dotenv-rails` – Gerenciamento de variáveis de ambiente em desenvolvimento.
* `bcrypt` – Criptografia e segurança para senhas de usuários.
* `rspec-rails` – Framework de testes para a aplicação.

---

## Configuração do Projeto

### Dependências do Sistema

* Ruby 3.4.4
* Rails 8.0.2
* MySQL

### Instalação

```bash
git clone https://github.com/Luiz-Fernando-Policarpo-Leandro/onibus_app.git
cd onibus_app
bundle install
```

### Banco de Dados

```bash
rails db:create db:migrate
```

### Executando o Servidor

```bash
rails server
```

O aplicativo estará disponível em `http://localhost:3000`.

---

## Testes

Para rodar a suíte de testes:

```bash
bundle exec rspec
```

---

## Variáveis de Ambiente

Crie um arquivo **`.env`** na raiz do projeto com o seguinte conteúdo:

```bash
# Configuração do Banco de Dados
MY_MYSQL_USER= "seu_usuario"
MY_MYSQL_PASSWORD= "sua_senha"

# Configuração do E-mail (Gmail)
MY_EMAIL_APP= "seu_email@gmail.com"
MY_PASSWORD_APP= "sua_app_password"
```

### Onde são usadas

* **Banco de dados** → `config/database.yml`:

```yml
username: <%= ENV["MY_MYSQL_USER"] %>
password: <%= ENV["MY_MYSQL_PASSWORD"] %>
```

* **E-mail** → `config/environments/development.rb`:

```ruby
config.action_mailer.smtp_settings = {
  user_name: ENV["MY_EMAIL_APP"],
  password:  ENV["MY_PASSWORD_APP"]
}
```

**Observações importantes**:

* Para usar Gmail, é necessário gerar uma **App Password** (senha de app) na conta Google. A senha normal não funciona.
* Nunca suba o arquivo `.env` para o GitHub. Certifique-se de incluí-lo no `.gitignore`.

---

## Funcionalidades do Sistema

### Usuários

* Cadastro e login com autenticação segura.
* Armazenamento de informações do usuário: CPF, CEP, matrícula, nome, role (função) e município.
* Admins podem gerenciar usuários (CRUD), com restrições de segurança.

### Sistema de Verificação

* Envio de código de verificação por e-mail.

### Ônibus e Rotas

* Cadastro e atualização de ônibus e suas rotas.

### Testes

* Testes automatizados com RSpec.

---

## Referências

* [Creating a User Login System - Ruby on Rails](https://dev.to/kjdowns/creating-a-user-login-system-ruby-on-rails-2kl2)
* [Action Mailer Rails](https://guiarails.com.br/action_mailer_basics.html)
* [RSpec Rails](https://rspec.info/features/6-0/rspec-rails/request-specs/request-spec/)

