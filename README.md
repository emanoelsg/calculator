# Calculadora Flutter 🧮

Uma calculadora simples e responsiva desenvolvida com **Flutter**.  
Funciona tanto em **layout mobile** quanto **desktop**, suportando operações aritméticas básicas e tratamento de erros.

---

## Autor
**Emanoel da Silva Gomes**  
- Email: emanoeldasilvagomes16@gmail.com  
- LinkedIn: [linkedin.com/in/emanoel-da-silva-gomes](https://www.linkedin.com/in/emanoel-da-silva-gomes-280787306)

---

## Funcionalidades

- ✅ Layout responsivo: Mobile & Desktop  
- ✅ Operações básicas: `+`, `-`, `x`, `/`  
- ✅ Botões de limpar (AC), apagar (⌫) e trocar sinal (+/-)  
- ✅ Tratamento de erros (divisão por zero, expressões inválidas)  
- ✅ Utiliza a biblioteca `math_expressions` para cálculos confiáveis  

---

## Demonstração Visual

### Layout Mobile
![Calculadora Mobile](flutter_01.png)

### Layout Desktop
![Calculadora Desktop](flutter_02.png)

---

## Badges

![Flutter](https://img.shields.io/badge/Flutter-3.9-blue?logo=flutter)  
![Dart](https://img.shields.io/badge/Dart-3.9-blue?logo=dart)  
![Licença](https://img.shields.io/badge/Licença-MIT-green)
## Estrutura do Projeto
bash
lib/
 ├── app/
 │   ├── pages/
 │   │   ├── calculator_page.dart
 │   │   ├── mobile_page.dart
 │   │   └── desktop_page.dart
 │   └── widgets/
 │       ├── calculator_buttons.dart
 │       └── calculator_display.dart
 └── main.dart

test/
 ├── logic_test.dart
 └── widget_test.dart
Testes
Para rodar todos os testes:

bash
Copiar código
flutter test
---

## Como Executar

### Pré-requisitos
- Flutter SDK >= 3.9.0
- Dart SDK

### Instalando
```bash
# Clonar o repositório
git clone https://github.com/seu-usuario/calculator.git

# Entrar na pasta do projeto
cd calculator

# Instalar dependências
flutter pub get

# Executar o app
flutter run

Licença
Este projeto possui licença MIT. Livre para uso e modificações.
