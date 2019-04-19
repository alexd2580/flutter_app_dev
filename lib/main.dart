import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:provider/provider.dart';
import 'package:sentry/sentry.dart';

import 'screens/Home.dart' as screens;
import 'screens/AnimeList.dart' as screens;
import 'screens/AnimeDetails.dart' as screens;

import 'store/AnimeList.dart' as store;
import 'store/AnimeDetailsView.dart' as store;

final app = MultiProvider(
    providers: [
      Provider<store.AnimeList>(value: store.AnimeList()),
      Provider<store.AnimeDetailsView>(value: store.AnimeDetailsView()),
    ],
    child: MaterialApp(
      title: 'Unofficial MAL viewer',
      home: screens.Home(),
      routes: {
        "/animes": (context) => screens.AnimeList(),
        "/anime": (context) => screens.AnimeDetails(),
      },
    ));

void main() async {
  final sentryDsn = await rootBundle.loadString('secrets/sentry.txt');
  final SentryClient sentry =
      sentryDsn != null ? SentryClient(dsn: sentryDsn) : null;

  FlutterError.onError = (FlutterErrorDetails details) =>
      Zone.current.handleUncaughtError(details.exception, details.stack);

  return runZoned(() => runApp(app), onError: (error, stackTrace) {
    if (sentry != null) {
      sentry.captureException(
        exception: error.toString(),
        stackTrace: stackTrace,
      );
    }
    print(error.toString());
    print(stackTrace);
  });
}
