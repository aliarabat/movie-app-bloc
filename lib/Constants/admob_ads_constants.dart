import 'package:firebase_admob/firebase_admob.dart';

class AdmobAdsConstants {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: <String>[],
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    childDirected: true,
    nonPersonalizedAds: true,
  );

  static const String bannerAdUnit = '';
  static const String interstitialAdUnit = '';
  static const String rewardedAdUnit = '';
}
