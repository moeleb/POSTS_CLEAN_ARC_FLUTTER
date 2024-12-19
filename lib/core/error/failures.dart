import 'package:equatable/equatable.dart';

abstract class AppFailure extends Equatable {}

class OfflineFailure extends AppFailure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends AppFailure {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EmptyCacheFailure extends AppFailure {
  @override
  List<Object?> get props => [];
}

/// failure bwejja exception