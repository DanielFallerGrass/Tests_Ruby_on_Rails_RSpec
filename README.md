# Minicurso de Testes para Ruby on Rails com RSpec
## _Principais elementos do Rspec_
- describe
- context
- it
- expect

### describe
 É usado para definir um "Grupo de Exemplos".
 Pode receber um nome de uma classe ou uma string com parâmetros.
 
```
describe Hero do
    ...
    ...
    ...
end 
```
### context
Agrupar testes associados ao mesmo contexto.
Não é obrigatório mas ajuda a tornar os testes mais legíveis e simples
```
describe Hero do
    context 'quando está com a armadura' do
        ...
        ...
    end
end 
```

### it
 É usado para definir um exemplo.
```
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

```
describe Hero do
    context 'quando está com a armadura'
        it 'tem 5000 pontos de vida' do
            hero = Hero.new
            expect(hero.hp).to eq(5000)
        end 
    end
end
    
**Free Software, Hell Yeah!**