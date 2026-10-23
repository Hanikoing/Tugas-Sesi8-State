
import 'package:flutter_test/flutter_test.dart';
import 'package:kampus_digital/main.dart';

void main() {
  testWidgets('Aplikasi Kampus Digital berhasil ditampilkan',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CampusApp());

    // Memastikan nama aplikasi tampil
    expect(find.text('Kampus Digital'), findsOneWidget);

    // Memastikan menu navigasi tampil
    expect(find.text('Beranda'), findsOneWidget);
    expect(find.text('Jadwal'), findsOneWidget);
    expect(find.text('Profil'), findsOneWidget);

    // Memastikan informasi mahasiswa tampil
    expect(find.text('Hanifatul Khoir'), findsOneWidget);
    expect(find.text('2495114001'), findsOneWidget);
  });

  testWidgets('Navigasi ke halaman jadwal',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CampusApp());

    await tester.tap(find.text('Jadwal'));
    await tester.pumpAndSettle();

    expect(find.text('Cari mata kuliah...'), findsOneWidget);
    expect(find.text('Senin'), findsOneWidget);
  });

  testWidgets('Navigasi ke halaman profil',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CampusApp());

    await tester.tap(find.text('Profil'));
    await tester.pumpAndSettle();

    expect(find.text('Informasi Mahasiswa'), findsOneWidget);
    expect(find.text('Absen Sekarang'), findsOneWidget);
  });
}
