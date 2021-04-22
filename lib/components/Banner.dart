import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CustomBanner extends StatefulWidget {
  @override
  _CustomBannerState createState() => _CustomBannerState();
}

class _CustomBannerState extends State<CustomBanner> {
  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-2248916584991987/3413038699',
    size: AdSize.fullBanner,
    request: AdRequest(),
    listener: AdListener(
      onAdLoaded: (Ad ad) => print('Ad loaded.'),
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        print('Ad failed to load: $error');
      },
      onAdOpened: (Ad ad) => print('Ad opened.'),
      onAdClosed: (Ad ad) => print('Ad closed.'),
      onApplicationExit: (Ad ad) => print('Left application.'),
    ),
  );

  @override
  void initState() {
    super.initState();
    myBanner.load();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: AdWidget(ad: myBanner),
      width: myBanner.size.width.toDouble(),
      height: myBanner.size.height.toDouble(),
    );
  }
}
