import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l/l.dart';
import 'package:stack_trace/stack_trace.dart';

extension on StringBuffer {
  void writeInfo(Object? object) {
    Type? type;
    assert(
      () {
        type = object.runtimeType;
        return true;
      }(),
    );

    write(type ?? object);
  }
}

class AppBlocObserver extends BlocObserver {
  static AppBlocObserver? _singleton;

  AppBlocObserver._();

  factory AppBlocObserver.instance() => _singleton ??= AppBlocObserver._();

  @override
  void onCreate(BlocBase<Object?> bloc) {
    super.onCreate(bloc);
    _log(
      (buffer) => buffer
        ..write('Created ')
        ..writeInfo(bloc),
    );
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    if (event == null) return;
    _log(
      (buffer) => buffer
        ..write('Event ')
        ..writeInfo(event)
        ..write(' in ')
        ..writeInfo(event),
    );
  }

  @override
  void onTransition(Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);
    final Object? event = transition.event;
    final Object? currentState = transition.currentState;
    final Object? nextState = transition.nextState;
    if (event == null || currentState == null || nextState == null) return;
    _log(
      (buffer) => buffer
        ..write('Transition in ')
        ..writeInfo(bloc)
        ..write(' with ')
        ..writeInfo(event)
        ..write(': ')
        ..writeInfo(transition.currentState)
        ..write(' -> ')
        ..writeInfo(transition.nextState),
    );
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    final trace = stackTrace;
    _log(
      (buffer) => buffer
        ..write('Error ')
        ..writeInfo(error)
        ..write(' in ')
        ..writeInfo(bloc)
        ..writeln(' StackTrace:')
        ..writeln('${Trace.from(trace).terse}'),
    );
  }

  @override
  void onClose(BlocBase<Object?> bloc) {
    super.onClose(bloc);
    _log(
      (buffer) => buffer
        ..write('Closed ')
        ..writeInfo(bloc),
    );
  }

  void _log(void Function(StringBuffer buffer) assemble) {
    final buffer = StringBuffer('[AppBlocObserver] - ');
    assemble(buffer);
    l.d(buffer.toString());
  }
}
