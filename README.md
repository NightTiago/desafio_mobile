# Documentação

### Instação do Mobile -

1. Baixar o projeto para o local;
2. Comandos para rodar:

```bash
flutter pub get
flutter run
```

## Requisitos do teste

- [x]  1. Tela de login usando (email e senha);
- [x]  2. Tela home com mapa renderizando um ponto na localização atual do device;
- [x]  3. Realizar o login utilizando Firebase Auth;
- [x]  4. Armazenar os dados do usuário na store
- [x]  5. Rastrear login com sucesso e renderização com sucesso com Analytics (enviar um evento com dados considerados primordiais nesses dois casos);
- [x]  6. Rastrear os erros e envia-los ao Crashlytics;
- [x]  7. Armazenar na base de dados local (preferência por WatermelonDB, mas pode usar outro banco de dados) o usuário logado e sua última posição no mapa;
- [x]  8. Testar fluxo de login (unit e e2e);
- [x]  9. Testar fluxo da home (unit e e2e).

