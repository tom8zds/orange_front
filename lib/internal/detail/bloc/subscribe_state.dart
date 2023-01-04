part of 'subscribe_bloc.dart';

@immutable
abstract class SubscribeState {}

class SubscribeInitial extends SubscribeState {}

class ParserLoading extends SubscribeState {}

class ParserDone extends SubscribeState {
  final List<ParserData> data;

  ParserDone(this.data);
}

class ParserFail extends SubscribeState {
  final Object exception;

  ParserFail(this.exception);
}
