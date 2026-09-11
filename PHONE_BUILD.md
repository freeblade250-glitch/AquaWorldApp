# Сборка APK без компьютера

1. На телефоне открой GitHub и создай новый репозиторий, например `AquaWorldApp`.
2. Распакуй ZIP и загрузи в репозиторий все файлы и папки, включая `.github/workflows/build-apk.yml`.
3. Открой вкладку **Actions**.
4. Выбери **Build AquaWorld APK**.
5. Нажми **Run workflow**.
6. После завершения открой выполненный workflow и скачай artifact **AquaWorld-APK**.
7. В архиве будет `app-release.apk`.

Для RuStore позже понадобится отдельная release-сборка и подпись приложения ключом разработчика.
