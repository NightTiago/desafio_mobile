import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

class AnalyticsService {

  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  FirebaseAnalyticsObserver getAnalyticsObserver() => FirebaseAnalyticsObserver(analytics: _analytics);

  Future logLogin() async {
    await _analytics.logLogin(
        loginMethod: 'email',
    );
  }

  Future logSignUp() async {
    await _analytics.logSignUp(signUpMethod: 'email');
  }

}