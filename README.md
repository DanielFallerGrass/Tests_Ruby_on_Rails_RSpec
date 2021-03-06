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
    gem 'rspec-rails', '~> 4.0.1'
    ...
  end
 ```

 Após rodar o

 ```
 bundle install 
 ```

## Criando Banco de Dados

 ```console
 rails db:create
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

- Ele é o arquivo base de configuração do Rspec

- Exemplo de configuração:

```rb
  config.order =:random # Quer dizer que os testes passarão de forma aleatória
```

## Arquivo "RAILS_HELPER

- Arquivo que carrega as dependencias do Rails e faz as configurações necessárias para que o Rspec rode em conjunto com ele

- Exemplo de configuração:

```rb
  config.use_transactional_fixtures = true # Significa que toda vez que rodar o teste o Banco de Dados será limpo antes.
```

# _Usando Generators_

## Generators no RSpec-Rail

- Scripts que geram arquivos de testes com a estrutura básica prota para que você possa criar seus testes facilmente

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

# _Testando Models_

## Porque e quando testar models

O que são models?

- São classes Ruby que se conectam às tabelas no banco de dados para permitir uma fácil manipulação delas.

Porque testar os models da sua aplicação?

- para garantir que a sua estrutura de dados esteja correta
  
Quando testar?

- Em geral, quando existem validações customizadas.

## Preparando nosso projeto para o teste

INCREMENTANDO NOSSO MODEL USER

```console
  # colocando 3 campos no model
  $ rails g migration add_name_kind_level_to_user nickname:string kind:integer level:integer
      invoke  active_record
      create    db/migrate/20220128184633_add_name_kind_level_to_user.rb
```

- O arquivo gerádo ficará da seguinte forma:

```rb
class AddNameKindLevelToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :nickname, :string
    add_column :users, :kind, :integer
    add_column :users, :level, :integer
  end
end
```

ATUALIZANDO O BANCO DE DADOS
Pós isso devemos rodar o

```console
  rails db:migrate 
```

Isso levará os campos novos para o _banco de dados_

MELHORANDO NOSSO MODEL
Criando um enum no model:

```rb
  enum kind: [ :knight, :wizard ]
```

INCLUINDO O MÉTODO TITTLE NO NOSSO MODEL

```rb
def tittle
  "#{self.kind} #{self.nickname} ##{self.level}"
end
```

INCLUINDO A VALIDAÇÃO DO LEVEL

```rb
validates: :level, numericality: {greather_than: 0, less_then_or_equal_to: 99}
```

RESULTADO DO MODEL USER

```rb
class User < ApplicationRecord
  enum kind: [ :knight, :wizard ]
  validates :leve, numericality: {greather_than: 0, less_than_or_equal_to: 99}

  def title
    "#{self.kind} #{self.nickname} ##{self.level}"
  end
end

```

## Preparando a base do nosso teste

Vamos ajustar o no spec do model user `spec/models/user_spec.rb`

```rb
require 'rails_helper'

RSpec.describe User, type: :model do
  it "is invalid if the level is not between 1 and 99"
  it "returns the correct hero title"
end  
```

IMPLEMENTANDO O NOSSO TESTE DO SPEC DO MODEL

```rb
require 'rails_helper'

RSpec.describe User, type: :model do
  it "is invalid if the level is not between 1 and 99" do
    expect(User.create(nickname: 'Chronos', kind: :wizard, level: 100)).to_not be_valid
  end

  it "returns the correct hero title" do
    user = User.create(nickname: 'Chronos', kind: :wizard, level:1)
    expect(user.title).to eq('wizard Chronos #1')
  end
end
```

Após isso é só rodar o `bundle exec rspec spec/models/user_spec.rb`
E deverá trazer o seguinte result:

```rb
Finished in 0.02444 seconds (files took 0.97558 seconds to load)
2 examples, 0 failures
```

## Melhorando o teste com a Gem FFaker

O que é a gem FFaker?

- Uma gem que permite gerar valores aleatórios
- exemplo:

 ```rb
  FFaker::Name.name #=> "Green wizard"
  FFaker::Internet.email #=> "green@wizard.com"
  FFaker::Address.city #=> "camelot"
 ```

Por que ela pode melhorar nossos testes?

- Porque ela ecita que criemos testes viciados, ou seja, que só funcionam com determinados valores de variáveis.

INCLUINDO A GEM FFAKER NO GEMFILE

```rb
group :development, :test do
  ...
  gem 'ffaker'
  ...  
```

Após inclusão, rode o `$ bundle install`.

MELHORANDO O TESTE DE LEVEL e TÍTULO

```rb
require 'rails_helper'

RSpec.describe User, type: :model do
  it "is invalid if the level is not between 1 and 99" do
    nickname = FFaker::Name.first_name
    kind = %i[ knight wizard ].sample
    level = FFaker::Random.rand(100..99999)
    user = User.new(nickname: nickname, kind: kind, level: level) #usando o new para criar uma instância do objeto "User"

    expect(user).to_not be_valid
  end

  it "returns the correct hero title" do
    nickname = FFaker::Name.first_name
    kind = %i[ knight, wizard ].sample
    level = FFaker::Random.rand(1..99)
    user = User.create(nickname: nickname, kind: kind, level: level) #usando o create para salvar na base o objeto "User"
    expect(user.title).to eq("#{kind} #{nickname} ##{level}")
  end
end
```

## Melhorando nosso teste com a Gem Factory Bot

O que é a Gem Factory Bot?

- Uma gerramenta para manipularmos records de frma organizada
- Exemplo:

```rb
  FactoryBot.defie do
    dactory :weapon do
      mame { 'excalibur' }
      kind { :sword }
```

Porque ela pode melhorar nossos testes?

- Porque nós conseguimos organizar melhor a gestão dos nossos records e passamos a escrever menos códigos repetidos (DRY)

INCLUINDO A GEM FACTORY BOT NO GEMFILE

```rb
group :development, :test do
  ...
  gem 'factory_bot_rails'
  ...  
```

Após inclusão, rode o `$ bundle install`.

INCLUINDO NO PROETO
Realizar a configuração no nosso arquivo spec/rails_helper.rb

```rb
  RSpec.configure do |config|
    ...
    config.include FactoryBot::Syntax::Methods
    ...
  end
```

CRIANDO A PRIMEIRA FACTORY

```console
  mkdir spec/factories
  touch spec/factories/user.rb
```

DESENVOLVENDO A FACTORY

```rb
FactoryBot.define do
  factory :user do
    nickname { FFaker::Lorem.word }
    level { FFaker::Random.rand(1..99) }
    kind { %i[ knight wizard ].sample}
  end
end
```

ATUALIZANDO OS TESTES LEVEL E TÍTULO

```rb
require 'rails_helper'

RSpec.describe User, type: :model do
  it "is invalid if the level is not between 1 and 99" do
    user = build(:user, level: FFaker::Random.rand(100..9999))
    expect(user).to_not be_valid
  end

  it "returns the correct hero title" do
    nickname = FFaker::Name.first_name
    kind = %i[ knight, wizard ].sample
    level = FFaker::Random.rand(1..99)

    user = create(:user, nickname: nickname, kind: kind, level: level)
    expect(user.title).to eq("#{kind} #{nickname} ##{level}")
  end
end

```

# _Testando Controller_

## O que são testes de Request

São testes de integração (são testes que testam vários componentes ao mesmo tempo) que realiza uma chamada completa ao endpoint e valida se o mesmo está respondendo adequadamente.

Exemplo

```rb
describe "GET /home" do
  it "has the message 'Hello World'" do
    get home_path
    expect(response.body).to include ("Hello World")
  end
end
```

## Criando nosso controller

```console
rails g controller users index create --no-helper --no-assets --no-controller-specs --no-view-specs-skip-routes
```

Resultado: app/controllers/user_controller.rb

```rb
class UserController < ApplicationController
  def index
  end

  def create
  end
end
```

Ajustando /spec/requests/users_spec.rb

```rb
require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    it "works! (now write some real specs)" do
      get users_path
      expect(response).to have_http_status(200)
    end

    it "the user's title is present" do
      users = create_list(:user, 3)
      get users_path
      users.each do |user|
        expect(response.body).to include(user.title)
      end
    end
  end

  describe "POST /users" do
    context "when it has valid parameters" do      
      it "creates the user with correct attributes" do
        user_attributes = FactoryBot.attributes_for(:user)
        post users_path, params: { user: user_attributes}
        expect(User.last).to have_attributes(user_attributes)
      end
    end

    context "when it has no valid parameters" do
      it "does not create user" do
        expect{
          post users_path, params: {user: {kind: '', name: '', level: ''}}
        }.to_not change(User, :count)
      end
    end
  end
end
```

# _Porque e quando testar API_

## O que é uma API

API's são maneiras de conectar serviços, com elas é possível se conectar ao google para traduzir uma frase ou ao Watson da IBM para realizar um processamento de linguagem natural.

## Que tipos de testes fazemos em APIs

Testes de request e testes unitários

## Como vamos testar?

Vamos incluir um novo controller com algumas actions no nosso projeto que vão funcionar como endpoints de uma API e depois vamos realizar os testes e as melhorias nos testes.

## Criando Controller Enemies

```console
rails g controller enemies update destroy --no-helper --no-assets --no-controller-specs --no-view-specs --skip-routes
```

Resultado: app/controllers/user_controller.rb

```rb
class EnemiesController < ApplicationController
  def update
  end

  def destroy
  end
end
```
## Criando o Model Enemy

```console
rails g model enemy name:string power_base:integer power_step:integer level:integer kind:integer
```

Resultado: app/model/enemy.rb

```rb
class Enemy < ApplicationRecord
end
```

## Atualizando o Banco de Dados

Após gerar o model é gerado uma migrate e precisamos atualizar o banco através do cmd:

```console
rails db:migrate
```

Resultado:
```console
== 20220418194831 CreateEnemies: migrating ====================================
-- create_table(:enemies)
   -> 0.0015s
== 20220418194831 CreateEnemies: migrated (0.0016s) ===========================
```
## Incluindo as validações e Métodos em Enemy
-> app/models/enemy.rb

```rb
class Enemy < ApplicationRecord
  enum kind: [:globin, :orc, :demon, :dragon]
  validates :level, numericality: { greater_than:0, less_than_or_equal_to: 99 }
  validates_presence_of :name, :power_base, :power_step, :level, :kind

  def current_power
    power_base + ((level - 1) * power_step)
  end
end
```

## Preparando os Métodos auxiliares no Controller
-> app/controllers/enemies_controller.rb

```rb
  before action :set_enemy

  private
  
  def enemy_params
    params.permit(:name, :power_base, :power_step, :level, :kind)
  end
  
  def set_enemy
    @enemy = Enemy.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: :not_found
  end
```

## Incluindo Método de Atualização
```rb
  def update
    if @enemy.update(enemy_params)
      render json: @enemy, status: :ok
    else
      render json: { erros: @enemy.erros }, status: :unprocessable_entity
    end
  end
```

## Incluindo Método de Remoção (Exclusão)

```rb
  def destroy
    @enemy.destroy
    heead 204
  end
```
## Atualizando as Rotas
-> config/routes.rb

```rb
resources :enemies, only: [:update, :destroy]
```

## Criando Factory
-> spec/factories/enemies.rb
```rb
FactoryBot.define do
  factory :enemy do
    name { FFaker::Lorem.word }
    power_base { FFaker::Random.rand(1..9999) }
    power_step { FFaker::Random.rand(1..9999) }
    level { FFaker::Random.rand(1..99) }
    kind { %w[goblin orc demon dragon].sample }
  end
end
```

## Testando o UPDATE enemies da API
### Gerando o Arquivo de Testes

Console:
```console
rails generate rspec:request Enemy
```

Resultado é criação de um arquivo de testes com o seguinte resultado:
```rb
require 'rails_helper'

RSpec.describe "Enemies", type: :request do
  describe "GET /enemies" do
    it "works! (now write some real specs)" do
      get enemies_path
      expect(response).to have_http_status(200)
    end
  end
end
```

### Incluindo os Testes do UPDATE
-> spec/request/enemmies_spec.rb

```rb
require 'rails_helper'

RSpec.describe 'Enemies', type: :request do
  describe 'PUT /enemies' do
    context 'when the enemy exists' do
      it 'returns status code 200' do
        enemy = create(:enemy)
        enemy_attributes = attributes_for(:enemy)
        put "/enemies/#{enemy.id}", params: enemy_attributes
        expect(response.to have_http_status(200)) # Verifica status do request
      end

      it 'updates the record' do
        enemy = create(:enemy)
        enemy_attributes = attributes_for(:enemy)
        put "/enemies/#{enemy.id}", params: enemy_attributes
        expect(enemy.reload).to have_attributes(enemy_attributes) # Quando existe atualiza o record
      end

      it 'returns the enemy updated' do
        enemy = create(:enemy)
        enemy_attributes = attributes_for(:enemy)
        put "/enemies/#{enemy.id}", params: enemy_attributes

        json_response = JSON.parse(response.body)
        expect(enemy.reload).to have_attributes(json_response.except('created_at', 'updated_at')) # Testando com o body
      end

    end

    context 'when the enemy does not exist' do
      it 'returns status code 404'
      it 'returns a not found message'
    end
  end
end
```

## Testando o Destroy enemies da API

### Incluindo os Testes do DESTROY
--> spec/request/enemies_spec.rb

```rb
  describe 'DELETE /enemies' do
    context 'when the enemy exists' do
      it 'returns status code 204' do
        enemy = create(:enemy)
        delete "/enemies/#{enemy.id}"
        expect(response).to have_http_status(204)
      end

      it 'destroy the record' do
        enemy = create(:enemy)
        delete "/enemies/#{enemy.id}"
        expect { enemy.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context 'when the enemy does not exists' do
      it 'returns status code 404' do
        delete "/enemies/0"
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        delete "/enemies/0"
        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end
  end
```
## O que é um Helper do RSPEC

Métodos que podem ser reaproveitdos ao longo dos  testes.
Exemplo:

Se cada teste vc precisasse fazer login
```rb
module Helpers
  module Authentication
    def sign_in_as(user)
     #Códigos para estabelecer o sign_in
    end
  end
end
```

### Criando o arquivo do Helper

```console
mkdir spec/support
touch spec/support/request_helper.rb
```

### Incluindo Nosso Módulo Helper de Request

```rb
module Request
  module JsonHelpers
    def json
      JSON.parse(response.body)
    end
  end
end
```

### Incluindo no RSPEC
-->spec/rails_helper.rb

Deve ser descomentado ou inserido caso não tenha o código abaixo:

```rb
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

RSpec.configure do |config|
  config.include Requests::JsonHelpers, type: :request
end
```

### Atualize o Teste: Quando o Inimigo Existe, Retorna o Inimigo Atualizado

```rb
      it 'returns the enemy updated' do
        enemy = create(:enemy)
        enemy_attributes = attributes_for(:enemy)
        put "/enemies/#{enemy.id}", params: enemy_attributes

        #json_response = JSON.parse(response.body) Agora podemos remover essa linha e alterar a chamada direton para o Json.except
        #expect(enemy.reload).to have_attributes(json_response.except('created_at', 'updated_at')) # Alterando de `json_Response` para `json` observe como diminuimos nosso código e podemos reaproveitar  nos demais lugares que tinhamos o `json_response`

        expect(enemy.reload).to have_attributes(json.except('created_at', 'updated_at')) # Testando com o body
      end
```

## Melhorando nosso Teste com BEFORE e LET !!!

O que é LET?

Let é uma maneira de definir métodos/ variáveis nos nossos testes que só carrega o valor quando é utilizado, e depois do promeiro uso mantém um cache do valor durante todo o teste.

Exemplo:

```rb
RSpec.describe Hero do
 let(:hero) { Hero.new }

  it "has a sword" do
    expect(hero.weapon).to eq('sword')
  end
 end
```

O que são HOOKS?

São métodos que permitem a execução de códigos antes ou depois dos testes.
Exemplo:

```rb
RSpec.describe Hero do
  let(:hero) {Hero.new}

  before(:each) do
    hero.update(weapon: 'axe') #atualizando antes do it
  end

  it 'Has an axe' do
    expect(hero.weapon).to eq('axe')
  end
end
```

MELHORANDO NOSSOS TESTES

DENTRO DO UPDATE NO CONTEXTO
"QUANDO O INIMIGO EXISTE"


Retirar de Cada Teste
```rb
  enemy = create(:enemy)
  enemy_attributes = attributes_for(:enemy)
  put "/enemies/#{enemy.id}", params: enemy_attributes
```

Colocar no lugar
```rb
  context 'when enemy exists' do
    let(:enemy) {create(:enemy)}
    let(:enemy_attributes) { attributes_for(:enemy) }

    before(:each) { put "enemies/#{enemy.id}", params: enemy_attributes }
  end
```

Como fica o contexto:
```rb
  context 'when the enemy exists' do

    let(:enemy) {create(:enemy)}
    let(:enemy_attributes) { attributes_for(:enemy) }
  
    before(:each) { put "enemies/#{enemy.id}", params: enemy_attributes }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'updates the record' do
      expect(enemy.reload).to have_attributes(enemy_attributes) # Quando existe atualiza o record
    end

    it 'returns the enemy updated' do
      expect(enemy.reload).to have_attributes(json.except('created_at', 'updated_at')) # Testando com o body
    end
  end
```


DENTRO DO UPDATE NO CONTEXTO
"QUANDO O INIMIGO _NÃO_ EXISTE"


Retirar de Cada Teste
```rb
put '/enemies/0', params: attributes_for(:enemy)
```

Colocar no lugar
```rb
before(:each) {put '/enemies/0', params: attributes_for(:enemy)}
```

Como fica o contexto:
```rb
  context 'when the enemy does not exist' do

    let(:enemy) {create(:enemy)}
    let(:enemy_attributes) { attributes_for(:enemy) }
  
    before(:each) { put "enemies/#{enemy.id}", params: enemy_attributes }

    it 'returns status code 404' do
      expect(response).to have_http_status(404)
    end
    it 'returns a not found message' do
      expect(response.body).to match(/Couldn't find Enemy/)
    end
  end
```


DENTRO DO DESTROY NO CONTEXTO
"QUANDO O INIMIGO EXISTE"


Retirar de Cada Teste
```rb
 enemy = create(:enemy)
 delete "/enemies/#{enemy.id}"
```

Colocar no lugar
```rb
let(:enemy) { create(:enemy) }
before(:each) {delete "/enemies/#{enemy.id}"}
```

Como que fica o contexto:
```rb
  context 'when the enemy exists' do

  let(:enemy) { create(:enemy) }
  before(:each) { delete "/enemies/#{enemy.id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'destroy the record' do
      expect { enemy.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end
```

DENTRO DO DESTROY NO CONTEXTO
"QUANDO O INIMIGO _NÃO_ EXISTE"


Retirar de Cada Teste
```rb
delete "/enemies/0"
```

Colocar no lugar
```rb
before(:each) {delete '/enemies/0'}
```

Como que fica o contexto:
```rb
  describe 'DELETE /enemies' do
    context 'when the enemy exists' do
      let(:enemy) { create(:enemy) }
      before(:each) { delete "/enemies/#{enemy.id}" }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'destroy the record' do
        expect { enemy.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context 'when the enemy does not exists' do
      before(:each) {delete '/enemies/0'}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end
  end
```
**Free Software, Hell Yeah!**
