import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Banner extends StatefulWidget {
  @override
  _BannerState createState() => _BannerState();
}

class _BannerState extends State<Banner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: adWidget,
      width: myBanner.size.width.toDouble(),
      height: myBanner.size.height.toDouble(),
    );
  }
}

final BannerAd myBanner = BannerAd(
  adUnitId: 'ca-app-pub-2248916584991987/3413038699',
  size: AdSize.fullBanner,
  request: AdRequest(),
  listener: AdListener(),
);

final AdListener listener = AdListener(
  onAdLoaded: (Ad ad) => print('Ad loaded.'),
  onAdFailedToLoad: (Ad ad, LoadAdError error) {
    print('Ad failed to load: $error');
  },
  onAdOpened: (Ad ad) => print('Ad opened.'),
  onAdClosed: (Ad ad) => print('Ad closed.'),
  onApplicationExit: (Ad ad) => print('Left application.'),
);

final AdWidget adWidget = AdWidget(ad: myBanner);


final Container adContainer = Container(
  alignment: Alignment.center,
  child: adWidget,
  width: myBanner.size.width.toDouble(),
  height: myBanner.size.height.toDouble(),
);