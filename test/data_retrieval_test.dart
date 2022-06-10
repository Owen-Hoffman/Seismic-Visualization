import 'package:seismic_visualization/widgets/main_graph.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('testing data entry in main graph', (tester) async {
    await tester.pumpWidget(RealTimeData(
      networkHolder: 'IU',
      locationHolder: '00',
      stationHolder: 'ANMO',
    ));
    final networkFinder = find.text('IU');
    final locationFinder = find.text('00');
    final stationFinder = find.text('ANMO');

    expect(networkFinder, findsOneWidget);
    expect(locationFinder, findsOneWidget);
    expect(stationFinder, findsOneWidget);
  });
}
