import 'package:equatable/equatable.dart';
abstract class Failure extends Equatable{}

class OffLineFailure extends Failure{
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure{
  @override
  List<Object?> get props => [];
}

class EmptyCashFailure extends Failure{
  @override
  List<Object?> get props => [];
}

class WrongDataFailure extends Failure{
  final String message;

  WrongDataFailure({required this.message});

  @override
  List<Object?> get props => [message];

}

class WrongUserNameFailure extends Failure{
  @override
  List<Object?> get props => [];
}

class BlockedFailure extends Failure{
  @override
  List<Object?> get props => [];
}

