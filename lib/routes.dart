import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/screens/article.dart';
import 'package:realworld_flutter/screens/article_editor.dart';
import 'package:realworld_flutter/screens/hero_splash.dart';
import 'package:realworld_flutter/screens/home.dart';
import 'package:realworld_flutter/screens/profile.dart';
import 'package:realworld_flutter/screens/profile_editor.dart';
import 'package:realworld_flutter/screens/sign_in.dart';
import 'package:realworld_flutter/screens/sign_up.dart';
import 'package:realworld_flutter/widgets/error_container.dart';

import 'application.dart';
import 'blocs/article/bloc.dart';
import 'blocs/profile/bloc.dart';
import 'blocs/user_profile/bloc.dart';
import 'screens/hero_splash.dart';

var bootStage = 1;

RouteFactory routes({
  @required Application application,
}) {
  return (RouteSettings settings) {
    var fullScreen = false;
    Widget screen;

    if (bootStage == 1) {
      bootStage = 2;

      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => HeroSplash(),
      );
    }
    final arguments = settings.arguments as Map<String, dynamic> ?? {};

    switch (settings.name) {
      case HomeScreen.route:
        screen = HomeScreen(
          userBloc: application.userBloc,
        );
        break;
      case ProfileScreen.route:
        screen = BlocProvider(
            create: (context) => ProfileBloc(
                  userRepository: application.userRepository,
                )..add(
                    LoadProfileEvent(username: arguments['username'] as String),
                  ),
            child: ProfileScreen(
              userBloc: application.userBloc,
              feed: arguments['feed'] as String,
            ));
        break;
      case ArticleScreen.route:
        screen = BlocProvider<ArticleBloc>(
          create: (context) => ArticleBloc(
            articlesRepository: application.articlesRepository,
          )..add(
              LoadArticleEvent(slug: arguments['slug'] as String),
            ),
          child: ArticleScreen(
            userBloc: application.userBloc,
          ),
        );
        break;
      case ArticleEditorScreen.route:
        fullScreen = true;
        screen = MultiBlocProvider(
          providers: [
            BlocProvider<ArticleBloc>(
              create: (_) => ArticleBloc(
                articlesRepository: application.articlesRepository,
              ),
            ),
          ],
          child: ArticleEditorScreen(
            slug: arguments['slug'] as String,
            userBloc: application.userBloc,
          ),
        );
        break;
      case SignUpScreen.route:
        fullScreen = true;
        screen = SignUpScreen();
        break;
      case SignInScreen.route:
        fullScreen = true;
        screen = SignInScreen();
        break;
      case ProfileEditorScreen.route:
        fullScreen = true;
        screen = MultiBlocProvider(
          providers: [
            BlocProvider<UserProfileBloc>(
              create: (context) => UserProfileBloc(
                userBloc: application.userBloc,
                userRepository: application.userRepository,
              ),
            ),
          ],
          child: ProfileEditorScreen(),
        );
        break;
      default:
        screen = ErrorContainer(
          title: 'Route ${settings.name} not found',
        );
    }

    if (bootStage == 2) {
      bootStage = 3;

      return PageRouteBuilder(
        pageBuilder: (BuildContext context, _, __) {
          return screen;
        },
        transitionDuration: const Duration(milliseconds: 500),
      );
    }

    if (fullScreen) {
      return MaterialPageRoute(
        builder: (_) => screen,
        fullscreenDialog: true,
      );
    }

    return PageRouteBuilder(
      pageBuilder: (BuildContext context, _, __) {
        return screen;
      },
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  };
}
