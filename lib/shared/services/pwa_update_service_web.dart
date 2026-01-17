import 'package:web/web.dart' as web;
import 'dart:js_interop';

class PwaUpdateService {
  static void setUpdateCallback(void Function() callback) {
    (web.window as WindowExtension).onPwaUpdateAvailable = callback.toJS;
  }

  static void reloadPwa() {
    web.window.location.reload();
  }
}

extension type WindowExtension(web.Window window) {
  external set onPwaUpdateAvailable(JSFunction callback);
}
