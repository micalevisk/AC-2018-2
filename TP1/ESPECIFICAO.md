# Trabalho Prático 1 - Exploração de Mapeamentos em Memória Cache
> - 29/08 ⇒ 28/09
> - **objetivo:** explorar conceitos sobre hierarquia de memória, mais precisamente sobre memórias caches. Deverá ser desenvolvida uma ferramenta através da qual o usuário poderá configurar a cache que pretende utilizar.


## Configuração
> escolhas referentes à memória principal e ao tipo de mapeamento de cache

- anotar o tempo de acesso (_hit time_)
- anotar o tempo causado pela penalidade decorrente de uma falha (_miss penalty_)


| tipo de mapeamento da cache | o usuário deverá |
|:---------------------------:|------------------|
| `direto` | - definir o número de linhas da cache **[potência de 2]**
|          | - definir o número de palavras por bloco **[potência de 2]**
|
| `conjunto associativo` |  - definir o número de conjuntos **[potência de 2]**
|                        |  - definir o número de palavras por bloco **[potência de 2]**
|                        | Usar o algoritmo LRU (a linha menos recentemente usada) como política de substituição


### saídas
- **em caso de Mapeamento Direto**: apresentar a estrutura de interpretação do endereço (ie., número de bits dedicados para TAG, ÍNDICE DE CACHE e BLOCO) além da informação de percentual de dados úteis possíveis de serem utilizados na cache
- **em caso de Mapeamento por Conjunto Associativo:** apresentar o tamanho de cada conjunto associativo (em bits) e o formato de interpretação (ie., número de bits dedicados para TAG, CONJUNTO e BLOCO).
- valor total do espaço de endereçamento (em bytes)
- tamanho total da memória principal (em bytes)
- número total de acertos (_hit_)
- número total de falhas (_miss_)
- tempo médio de acesso
- tempo total de execução

## Simulação/Validação

Para validar, o sistema deverá ler um arquivo que define os endereços (em decimal) que serão acessados -- sendo uma linha para cada endereço, representando uma requisição de acesso à memória feita por um processador.
A cada endereço requisitado, deverá ser anotado se o mesmo gerou um **acerto** ou uma **falha** na cache. A sequência de requisições deverá ser executada sobre a arquitetura de cache configurada.

A execução das requisições deverá ser feita passo a passo a fim de poder ser visualizada a substituição das linhas da cache, bem como as situações de acerto e falha na carga da cache.

## Documentação/Manaul do usuário

As seguintes informações são requisitadas no documento:
1. Introdução
    1. Resumo da ferramenta
2. Compilação
    1. Linguagem e ambiente de desenvolvimento empregados
    2. Método de compilação
3. Interface
    1. Descrição de como manipular a ferramenta.
        1. Detalhamento sobre os campos a serem preenchidos.
        2. Detalhamento sobre como carregar arquivos de teste.
        3. Detalhamento sobre os resultados obtidos da operação
4. Exemplo de uso
