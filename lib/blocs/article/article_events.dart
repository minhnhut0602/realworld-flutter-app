import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:realworld_flutter/api/model/new_comment.dart';
import 'package:realworld_flutter/api/model/update_article.dart';

@immutable
abstract class ArticleEvent extends Equatable {
  const ArticleEvent([List props = const []]) : super(props);
}

@immutable
class LoadArticleEvent extends ArticleEvent {
  final String slug;
  const LoadArticleEvent({
    this.slug,
  });
  @override
  String toString() => 'LoadArticleEvent[$slug]';
}

@immutable
class UpdateArticleEvent extends ArticleEvent {
  final String slug;
  final UpdateArticle article;
  const UpdateArticleEvent({
    this.slug,
    this.article,
  });
  @override
  String toString() => 'UpdateArticleEvent[slug: $slug, article: $article]';
}

@immutable
class CreateCommentEvent extends ArticleEvent {
  final String slug;
  final NewComment comment;
  const CreateCommentEvent({
    this.slug,
    this.comment,
  });
  @override
  String toString() => 'CreateCommentEvent[slug: $slug, comment: $comment]';
}

@immutable
class DeleteCommentEvent extends ArticleEvent {
  final String slug;
  final int id;
  const DeleteCommentEvent({
    this.slug,
    this.id,
  });
  @override
  String toString() => 'DeleteCommentEvent[slug: $slug, id: $id]';
}
