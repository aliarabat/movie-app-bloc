import 'package:firebase_admob/firebase_admob.dart';

class AdmobAdsConstants {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: <String>[],
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    childDirected: true,
    nonPersonalizedAds: true,
  );

  static const String appAdUnitId = 'ca-app-pub-1601402134754526~1998503578';
  static const String bannerAdUnit = 'ca-app-pub-1601402134754526/4907677753';
  static const String interstitialAdUnit = 'ca-app-pub-1601402134754526/8655351074';
  static const String rewardedAdUnit = 'ca-app-pub-1601402134754526/7645521734';
}
