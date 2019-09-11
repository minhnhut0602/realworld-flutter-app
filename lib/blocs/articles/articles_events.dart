import 'package:meta/meta.dart';

/*
@immutable
abstract class ArticlesEvent extends Equatable {
  const ArticlesEvent([List props = const []]) : super(props);
}
*/

abstract class ArticlesEvent {}

@immutable
class LoadArticlesEvent extends ArticlesEvent {
  final String tag;
  final String author;
  final String favorited;
  final bool refresh;
  LoadArticlesEvent({
    this.tag,
    this.author,
    this.favorited,
    this.refresh = false,
  }); // : super([tag, author, favorited, refresh]);
  @override
  String toString() =>
      'LoadArticles[tag: $tag, author: $author, favorited: $favorited, refresh: $refresh]';
}

@immutable
class LoadArticlesFeedEvent extends ArticlesEvent {
  final bool refresh;
  LoadArticlesFeedEvent({
    this.refresh = false,
  }); // : super([refresh]);
  @override
  String toString() => 'LoadArticlesFeed[]';
}

@immutable
class ToggleFavoriteEvent extends ArticlesEvent {
  final String slug;
  ToggleFavoriteEvent({
    this.slug,
  }); // : super([slug]);
  @override
  String toString() => 'ToggleFavoriteEvent[slug: $slug]';
}