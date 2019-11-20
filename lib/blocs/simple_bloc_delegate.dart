import 'package:bloc/bloc.dart';
import 'package:flutter_douban2/util/log_util.dart';
class SimpleBlocDelegate extends BlocDelegate{
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    LogUtil.log('SimpleBlocDelegate onEvent $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    LogUtil.log('SimpleBlocDelegate onTransition $transition');
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    LogUtil.log('SimpleBlocDelegate onError $error');
  }
}