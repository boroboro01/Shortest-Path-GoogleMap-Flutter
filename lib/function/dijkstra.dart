import 'package:haversine_distance/haversine_distance.dart';

class Dijkstra {
  double INF = 999999;

  final haversineDistance = HaversineDistance();
  late List<double> dist;
  late List<bool> visit;
  List<int> route = [0];
  int start = 0;

  // 배열 초기화
  void init(int length) {
    dist = List.filled(length, INF);
    visit = List.filled(length, false);
    print(dist);
    print(visit);
  }

  // 두 위치의 최소 거리 계산
  double min(Location start, Location end) {
    final distanceInMeter = haversineDistance.haversine(
      start,
      end,
      Unit.METER,
    );
    print("distance = $distanceInMeter");
    return distanceInMeter;
  }

  // 다익스트라 계산
  List<int> calculate(List<Location> locations) {
    int length = locations.length;

    for (int i = 1; i < length; i++) {
      dist[i] = min(locations[start], locations[i]);
    }
    dist[start] = 0;
    visit[start] = true;

    for (int i = 0; i < length - 1; i++) {
      int newNode = findShortestNode(length);
      visit[newNode] = true;
      print('visit: $newNode');
      route.add(newNode);
      updateDist(newNode, locations);
    }

    return route;
  }

  int findShortestNode(int length) {
    double minDist = INF;
    int minIdx = -1;
    for (int i = 0; i < length; i++) {
      if (visit[i] == true) continue;
      if (dist[i] < minDist) {
        minDist = dist[i];
        minIdx = i;
      }
    }
    return minIdx;
  }

  void updateDist(int newNode, List<Location> locations) {
    for (int i = 1; i < locations.length; i++) {
      if (visit[i] == true) {
        continue;
      }
      double minDist = min(locations[newNode], locations[i]);
      if (dist[i] > dist[newNode] + minDist) {
        dist[i] = dist[newNode] + minDist;
      }
    }
  }
}
