import 'package:logger/logger.dart';

/// アプリ全体で使用するロガークラス
class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // 表示されるメソッドコールの数
      errorMethodCount: 8, // エラー時のメソッドコールの数
      lineLength: 120, // 行の長さ
      colors: true, // 色付きで出力
      printEmojis: true, // 絵文字を表示
      dateTimeFormat: DateTimeFormat.dateAndTime, // タイムスタンプの表示
    ),
  );

  /// 詳細なデバッグ情報
  static void t(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.t(message, error: error, stackTrace: stackTrace);
  }

  /// デバッグ情報
  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// 一般的な情報
  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// 警告
  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// エラー
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// 重大なエラー
  static void f(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }
}
