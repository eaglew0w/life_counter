import 'package:web/web.dart' as web;
import 'dart:js_interop';

class PwaUpdateService {
  static void setUpdateCallback(void Function() callback) {
    (web.window as WindowExtension).onPwaUpdateAvailable = callback.toJS;
  }

  static void reloadPwa() {
    web.window.location.reload();
  }

  static void checkForUpdate() {
    (web.window as WindowExtension).checkForPwaUpdate();
  }
}

extension type WindowExtension(web.Window window) {
  external set onPwaUpdateAvailable(JSFunction callback);
  external void checkForPwaUpdate();
}
