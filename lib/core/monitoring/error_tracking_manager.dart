import 'dart:async';

import '../utils/logger.dart';

/// {@template error_tracking_manager}
/// A class which is responsible for enabling error tracking.
/// {@endtemplate}
abstract interface class ErrorTrackingManager {
  /// Handles the log message.
  ///
  /// This method is called when a log message is received.
  Future<void> report(LogMessage log);

  /// Enables error tracking.
  ///
  /// This method should be called when the user has opted in to error tracking.
  Future<void> enableReporting();

  /// Disables error tracking.
  ///
  /// This method should be called when the user has opted out of error tracking
  Future<void> disableReporting();
}
