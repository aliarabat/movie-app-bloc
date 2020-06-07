import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SearchMoviesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchMoviesData extends SearchMoviesEvent {
  final String keyword;

  FetchMoviesData(this.keyword);

  @override
  List<Object> get props => [keyword];
}
