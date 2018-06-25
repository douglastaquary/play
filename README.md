# Play

[![License](http://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/douglastaquary/play/blob/master/LICENSE)
[![Build Status](https://img.shields.io/travis/douglastaquary/play/master.svg?style=flat)](https://travis-ci.org/douglastaquary/play)
[![codecov](https://codecov.io/gh/douglastaquary/play/branch/master/graph/badge.svg)](https://codecov.io/gh/douglastaquary/play)


## Motivação

Aplicativo para demonstrar o uso de padrões de desenvolvimento de apps iOS. O app lista filmes e mostra algumas informações sobre o filme selecionado. 

O aplicativo consome dados de uma API open source com informações de filmes chamada [The Movie DB](https://www.themoviedb.org/documentation/api?language=pt-BR).

## Ferramentas de Testes

Esse projeto dois frameworks de Testes:

- [Quick](https://github.com/Quick/Quick) |  Behavior-drive development framework para swift e objective-C que vem junto com Nimble.

- [Nimble](https://github.com/Quick/Nimble) | Matcher framework

## Instalação

Esse projeto usa [Bundler](http://bundler.io) e [Cocoapods](https://cocoapods.org). É necessário executar os seguintes comandos:

Caso você não tenha o Bundler instalado, execute:

```
gem install bundler
```

Em seguida:

```
bundle 
bundle exec pod install
```

## Testes 

Para executar os testes, executar o comando: 

```
bundle exec fastlane test
```

## Cobertura de Testes

- [Slather](https://github.com/SlatherOrg/slather) |  Framework que gera relatórios com cobertura de código para projetos do Xcode.

