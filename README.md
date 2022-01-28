# Minicurso de Testes para Ruby on Rails com RSpec

## Instalando GEM RSpec
- Para instalar a gem do RSpec basta ler o seguinte arquivo [link](https://github.com/DanielFallerGrass/Tests_Ruby_on_Rails_RSpec/blob/main/leia-me.txt).
## _Principais elementos do Rspec_
- describe
- context
- it
- expect

### describe
 É usado para definir um "Grupo de Exemplos".
 Pode receber um nome de uma classe ou uma string com parâmetros.
 
```rb
describe Hero do
    ...
    ...
    ...
end 
```
### context
Agrupar testes associados ao mesmo contexto.
Não é obrigatório mas ajuda a tornar os testes mais legíveis e simples
```rb
describe Hero do
    context 'quando está com a armadura' do
        ...
        ...
    end
end 
```

### it
 É usado para definir um exemplo.
```rb
describe Hero do
    context 'quando está com a armadura' do
        it 'tem 5000 pontos de vida' do
            ...
        end
    end
end
```

### expect
 É onde verificamos se uma determinada condição está ocorrendo para concluirmos que nosso teste passou.

```rb
describe Hero do
    context 'quando está com a armadura'
        it 'tem 5000 pontos de vida' do
            hero = Hero.new
            expect(hero.hp).to eq(5000)
        end 
    end
end
```

# _Matchers_
Matcher é uma intrução para verificar se uma determinada intrução está sendo atendida
```rb
expect(message).to eq"Hello World!"
```
### Matcher de equivalência e identidade
```rb
# Passa se o valor for == esperado
expect(atual).to eq(expected)

# Passa se x.eql?(y)
expect(x).to eql?(y)

# Passa se x .equal?(y) "o equal? retorna falso nos testes com strings e com números, porque esse método verifica se as variáveis referenciam o mesmo objeto, ou seja, ele checa se possuem o mesmo id"
expect(atual).to be(expected)


str1 = 'Hello World'
str2 = 'Hello World'

str1 == str2 #=> true
str1.eql? str2 #=> true
str1.equal? str2 #=> false

value1 = 1
value2 = 1.0

value1 == value2 #=> true
value1.eql? value2 #=> false
value1.equal? value2 #=> false
```
Material de apoio : 
- [Diferença entre eql? e equal?](https://www.campuscode.com.br/conteudos/igualdade-de-objetos-em-ruby#:~:text=Comparando%20strings%2C%20eql%3F,falso%2C%20enquanto%20%3D%3D%20%2C%20verdadeiro)
- [Diferença entre .dup e .clone](https://coderwall.com/p/1zflyg/ruby-the-differences-between-dup-clone)


### Matchers de comparação
```rb
# Passa se o valor for maior que x
expect(actual).to be > x

# Passa se o valor for menor que x
expect(actual).to be < x

# Passa se o valor for menor ou igual a x
expect(actual).to be <= x

# Passa se o valor for maior ou igual a x
expect(actual).to be => x

# Passa se o valor bater com a expresão regular (REGEX)
expect(actual).to match(/expression /)

```

### Matchers de classe e tipo
 ```rb
 # Passa se o objecto for uma instância da classe esperada
 expect(actual).to be_an_instance_off(expect)

 # Passa se o tipo do objeto for o esperado
 expect(actual).to be_a(expect)
 ```

### Matchers TRUE/FALSE/NIL
```rb
#Passa enquanto o valor não for false ou nil
expect(actual).to be_truthy

# Passa quando o valor for == true
expect(actual).to be true

# Passa se o valor for false ou nil
expect(actual.to be_falsy

# Passa quando valor for ==false
expect(actual).to be false

# Passa se o valor for nil
expect(actual).to be_nil

# Passa se o valor não for nil
expect(actual).to_not be_nil
```

### Matchers de erro

```rb
# Passa se a chamada levantar um erro
expect( ... ).to raise_error

# Passa se a chamada levantar um erro do tipo ErrorClasss
expect( ... ).to raise_error(ErrorClass)

# Passa se a chamada levantar um erro com a mensagem "mesagem"
expect( ... ).to raise_error("message")

# Passa se a chamada levantar um erro do tipo ErrorClass com a mensagem "message"
expect( ... ).to raise_error(ErrorClass, "message")
```
Existem outros Matchers, o link para conhecer todos eles: [Link de Matchers](http://ruby-doc.org/core-2.6.1/Object.html#method-i-eql-3F)

# _Instalando o RSpec no Rails_
## Criando um novo projeto Rails
 ```console
 $ rails new test_like_a_hero
   create
   create README.md
   create Rakefile
   create .ruby-version
   create config.ru
   create .gitignore
   create Gemfile
 ```
 ## Incluindo o RSpec no Gemfile
 ```rb
  group :development, :test do
    ...
    gem 'rspec-rails', '~>3.8'
    ...
  end
 ```

 Após rodar o 
 ``` 
 $ bundle install 
 ```

 ## Criando Banco de Dados
 ```console
 $ rails db:create
 ```
Obs: Quando você cria o projeto o rails tem 3 bancos de dados: teste, development, production
 ## Instale o Rspec
 ```console
  $ rails generate rspec:install
    Running via Spring preloader in process 11272
      create .rspec
      create spec
      create spec/spec_helper.rb
      create spec/rails_helper.rb
 ```
 
 Você pode rodar o seguinte comando apenas para confirmar se os testes estão passando corretamente:
 ```console
  $ bundle exec rspec
  No examples found

  Finished in 0.00032 seconds (files took 0.21942 seconds to load)
  0 examples, 0 failures
 ```

## Arquivo "SPEC_HELPER.RB"
* Ele é o arquivo base de configuração do Rspec
* Exemplo de configuração:
```rb
  config.order =:random # Quer dizer que os testes passarão de forma aleatória
```

## Arquivo "RAILS_HELPER
* Arquivo que carrega as dependencias do Rails e faz as configurações necessárias para que o Rspec rode em conjunto com ele
* Exemplo de configuração: 
```rb
  config.use_transactional_fixtures = true # Significa que toda vez que rodar o teste o Banco de Dados será limpo antes.
```

# _Usando Generators_
##  Generators no RSpec-Rail
* Scripts que geram arquivos de testes com a estrutura básica prota para que você possa criar seus testes facilmente

Coonhecendo alguns `generators`:

GERANDO UM MODEL COM TESTE
```console
  $  rails generate model user
      invoke  active_record
      create    db/migrate/20220128181255_create_users.rb
      create    app/models/user.rb
      invoke    rspec
      create      spec/models/user_spec.rb
```
Esse comando irá criar os arquivo supracitados referente ao `model` do `user_spec.rb` e ficará da seguinte forma:
```rb
require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
```

GERANDO UM TESTE DE REQUEST
```console
$  rails generate rspec:request User
      create  spec/requests/users_spec.rb
```

Esse comando irá criar o arquivo referente a `request` do `user_spec.rb` e ficará da seguinte forma:
```rb
require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    it "works! (now write some real specs)" do
      get users_path
      expect(response).to have_http_status(200)
    end
  end
end
```

CONHECENDO TODAS AS OPÇÕES
```console
  $ rails generate --help | grep rspec
  rspec:controller
  rspec:feature
  rspec:generators
  rspec:helper
  rspec:install
  rspec:integration
  rspec:job
  rspec:mailer
  rspec:model
  rspec:observer
  rspec:request
  rspec:scaffold
  rspec:system
  rspec:view
```

**Free Software, Hell Yeah!**