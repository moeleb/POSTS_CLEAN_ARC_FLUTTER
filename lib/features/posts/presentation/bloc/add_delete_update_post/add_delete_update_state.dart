abstract class AddDeleteUpdateState {}

class AddDeleteUpdateStateInitial extends AddDeleteUpdateState {}

class LoadingAddDeleteUpdateState extends AddDeleteUpdateState {}

class ErrorAddDeleteUpdateState extends AddDeleteUpdateState {
  final String message;

  ErrorAddDeleteUpdateState({required this.message});
}

class MessageAddDeleteUpdateState extends AddDeleteUpdateState {
  final String message;

  MessageAddDeleteUpdateState({required this.message});
}
