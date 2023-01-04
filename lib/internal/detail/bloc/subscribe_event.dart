part of 'subscribe_bloc.dart';

@immutable
abstract class SubscribeEvent {}

class QueryParserEvent extends SubscribeEvent {
  final String animeName;

  QueryParserEvent(this.animeName);
}
