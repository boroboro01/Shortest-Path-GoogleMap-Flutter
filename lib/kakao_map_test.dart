import 'package:flutter/material.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';

const String kakaoMapKey = 'javascript key';

class KakaoMapTest extends StatelessWidget {
  const KakaoMapTest({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // KakaoMapView
          Expanded(
            child: KakaoMapView(
                width: size.width,
                height: 800,
                kakaoMapKey: kakaoMapKey,
                lat: 33.450701,
                lng: 126.570667,
                showMapTypeControl: true,
                showZoomControl: true,
                markerImageURL:
                    'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png',
                onTapMarker: (message) async {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Marker is clicked')));
                  //await _openKakaoMapScreen(context);
                }),
          )
        ],
      ),
    );
  }

  // kakao map 지도 검색으로 이동
  Future<void> _openKakaoMapScreen(BuildContext context) async {
    KakaoMapUtil util = KakaoMapUtil();
    String url =
        await util.getMapScreenURL(33.450701, 126.570667, name: 'Kakao 본사');

    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (_) => KakaoMapScreen(url: url)));
  }
}
