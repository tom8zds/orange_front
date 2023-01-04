part of 'subscribe_index_bloc.dart';

@immutable
abstract class SubscribeIndexState {}

class SubscribeIndexInitial extends SubscribeIndexState {}

class SubscribeIndexLoading extends SubscribeIndexState {}

class SubscribeIndexFinish extends SubscribeIndexState {
  final List<SubscribeItem> data;

  SubscribeIndexFinish(this.data);
}

class SubscribeIndexFail extends SubscribeIndexState {
  final Object exception;

  SubscribeIndexFail(this.exception);
}
