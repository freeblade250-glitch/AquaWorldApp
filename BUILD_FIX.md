# Исправленная сборка AquaWorld

Предыдущая сборка падала потому, что `flutter create` заменял `lib/main.dart` стандартным примером Flutter. В новом workflow исходники AquaWorld сначала сохраняются, Android-часть создаётся, затем исходники восстанавливаются.

В GitHub замените содержимое `.github/workflows/build-apk.yml` на файл из этого архива и запустите Actions заново.
