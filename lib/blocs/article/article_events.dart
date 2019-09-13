part of blocs.article;

@immutable
abstract class ArticleEvent extends Equatable {
  const ArticleEvent([List props = const []]) : super(props);
}

@immutable
class LoadArticleEvent extends ArticleEvent {
  final String slug;
  const LoadArticleEvent({
    @required this.slug,
  });
  @override
  String toString() => 'LoadArticleEvent[$slug]';
}

class CreateArticleEvent extends ArticleEvent {
  final ArticleSubmission article;
  CreateArticleEvent({
    this.article,
  });
  @override
  String toString() => 'CreateArticleEvent[article: $article]';
}

@immutable
class UpdateArticleEvent extends ArticleEvent {
  final String slug;
  final ArticleSubmission article;
  const UpdateArticleEvent({
    @required this.slug,
    @required this.article,
  });
  @override
  String toString() => 'UpdateArticleEvent[slug: $slug, article: $article]';
}

@immutable
class DeleteArticleEvent extends ArticleEvent {
  final String slug;
  const DeleteArticleEvent({
    @required this.slug,
  });
  @override
  String toString() => 'DeleteArticleEvent[slug: $slug]';
}

@immutable
class ToggleFavoriteEvent extends ArticleEvent {
  final String slug;
  ToggleFavoriteEvent({
    @required this.slug,
  }); // : super([slug]);
  @override
  String toString() => 'ToggleFavoriteEvent[slug: $slug]';
}
