import 'package:haversine_distance/haversine_distance.dart';

class Dijkstra {
  double INF = 99999;

  final haversineDistance = HaversineDistance();
  List<double> dist = [];
  List<bool> visit = [];
  int start = 0;

  double min(Location start, Location end) {
    final distanceInMeter = haversineDistance.haversine(
      start,
      end,
      Unit.METER,
    );
    print("distance = $distanceInMeter");
    return distanceInMeter;
  }

  void calculate(List<Location> locations) {
    for (int i = 1; i <= locations.length; i++) {
      dist[i] = min(locations[start], locations[i]);
      visit[i] = false;
    }
    dist[start] = 0;
    visit[start] = true;

    // for (int i = 0; i < N - 1; i++);
  }

  int findShortestNode(int length) {
    double minDist = INF;
    int minIdx = -1;
    for (int i = 0; i <= length; i++) {
      if (visit[i] == true) {
        continue;
      }
      if (dist[i] < minDist) {
        minDist = dist[i];
        minIdx = i;
      }
    }
    return minIdx;
  }
}
