import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterstackapp/home/index.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  // An empty private constructor
  HomeBloc._internal();
  // A static reference to the singleton
  static final HomeBloc _homeBlocSingleton = HomeBloc._internal();
  // Always return the singleton
  factory HomeBloc() {
    return _homeBlocSingleton;
  }

  /// An placeholder object for 'uninitialised'
  @override
  HomeState get initialState => new UnHomeState();

  /// A function which defines how an event received from
  /// the UI is reflected back as a new state
  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: currentState, bloc: this);
    } catch (_) {
      print('HomeBloc ' + _?.toString());
      yield currentState;
    }
  }
}
