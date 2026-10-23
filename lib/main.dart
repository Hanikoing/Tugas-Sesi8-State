import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const CampusApp());

const violet = Color(0xFF6C4CF1);
const ink = Color(0xFF211A3C);
const canvas = Color(0xFFF7F6FC);
const mint = Color(0xFF26A887);

class CampusApp extends StatefulWidget {
  const CampusApp({super.key});

  @override
  State<CampusApp> createState() => _CampusAppState();
}

class _CampusAppState extends State<CampusApp> {
  bool dark = false;

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kampus Digital',
        themeMode: dark ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: violet),
          scaffoldBackgroundColor: canvas,
          appBarTheme: const AppBarTheme(
            backgroundColor: canvas,
            foregroundColor: ink,
            elevation: 0,
          ),
          cardTheme: CardThemeData(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Color(0xFFECEAF4)),
            ),
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
            seedColor: violet,
            brightness: Brightness.dark,
          ),
          cardTheme: CardThemeData(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        home: CampusHome(
          dark: dark,
          onTheme: () => setState(() => dark = !dark),
        ),
      );
}

class Course {
  final int weekday;
  final String name;
  final String lecturer;
  final String time;
  final String room;
  final IconData icon;
  final List<String> materials;
  final List<Assignment> assignments;

  const Course({
    required this.weekday,
    required this.name,
    required this.lecturer,
    required this.time,
    required this.room,
    required this.icon,
    required this.materials,
    required this.assignments,
  });
}

class Assignment {
  final String title;
  final String description;
  final int daysFromNow;
  bool done;

  Assignment({
    required this.title,
    required this.description,
    required this.daysFromNow,
    this.done = false,
  });
}

final List<Course> courses = [
  Course(
    weekday: DateTime.sunday,
    name: 'Pemrograman Web Lanjut',
    lecturer: 'EDWIN HARI AGUS PRASTYO',
    time: '13.00 - 15.30 WIB',
    room: 'Laboratorium Komputer FTI',
    icon: Icons.code_rounded,
    materials: [
      'Pengantar pemrograman web lanjut',
      'Framework web dan routing',
      'Integrasi database',
      'Validasi form dan autentikasi',
    ],
    assignments: [
      Assignment(
        title: 'Membuat halaman web dinamis',
        description:
            'Buat halaman web dengan routing dan validasi form.',
        daysFromNow: 2,
      ),
      Assignment(
        title: 'Praktik integrasi database',
        description:
            'Hubungkan aplikasi dengan database dan tampilkan data.',
        daysFromNow: 6,
      ),
    ],
  ),
  Course(
    weekday: DateTime.monday,
    name: 'Teori Graf dan Otomata',
    lecturer: 'ANITA ANDRIANI',
    time: '08.00 - 10.30 WIB',
    room: 'Kelas TI B.201',
    icon: Icons.hub_rounded,
    materials: [
      'Konsep dasar teori graf',
      'Jenis dan representasi graf',
      'Lintasan, sirkuit, dan keterhubungan',
      'Pengantar teori otomata',
    ],
    assignments: [
      Assignment(
        title: 'Latihan teori graf',
        description:
            'Kerjakan latihan representasi graf dan lintasan.',
        daysFromNow: 3,
      ),
    ],
  ),
  Course(
    weekday: DateTime.tuesday,
    name: 'Mobile Programming',
    lecturer: 'EDWIN HARI AGUS PRASTYO',
    time: '08.00 - 10.30 WIB',
    room: 'Laboratorium Komputer FTI',
    icon: Icons.phone_android_rounded,
    materials: [
      'Pengenalan Flutter dan Dart',
      'Widget dan layout',
      'State dan interaksi pengguna',
      'Navigasi antarhalaman',
    ],
    assignments: [
      Assignment(
        title: 'Aplikasi interaktif Flutter',
        description:
            'Buat aplikasi sederhana yang menerapkan state dan interaksi pengguna.',
        daysFromNow: 4,
      ),
      Assignment(
        title: 'Uji aplikasi',
        description:
            'Buat dan jalankan widget test untuk fitur utama.',
        daysFromNow: 8,
      ),
    ],
  ),
  Course(
    weekday: DateTime.wednesday,
    name: 'Game Development Techniques',
    lecturer: 'GINANJAR SETYO PERMADI',
    time: '08.00 - 10.30 WIB',
    room: 'Smart Classroom (B.205)',
    icon: Icons.sports_esports_rounded,
    materials: [
      'Dasar game development',
      'Game loop dan input pemain',
      'Physics dan collision',
      'Level design dan mekanik permainan',
    ],
    assignments: [
      Assignment(
        title: 'Prototype game sederhana',
        description:
            'Buat prototype game dengan kontrol pemain dan satu tujuan permainan.',
        daysFromNow: 5,
      ),
    ],
  ),
];

class CampusHome extends StatefulWidget {
  final bool dark;
  final VoidCallback onTheme;

  const CampusHome({
    super.key,
    required this.dark,
    required this.onTheme,
  });

  @override
  State<CampusHome> createState() => _CampusHomeState();
}

class _CampusHomeState extends State<CampusHome> {
  int tab = 0;
  bool present = false;
  String search = '';

  late DateTime now;
  Timer? clockTimer;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();

    clockTimer = Timer.periodic(
      const Duration(minutes: 1),
      (_) {
        if (!mounted) return;

        final current = DateTime.now();

        if (current.year != now.year ||
            current.month != now.month ||
            current.day != now.day) {
          setState(() => now = current);
        }
      },
    );
  }

  @override
  void dispose() {
    clockTimer?.cancel();
    super.dispose();
  }

  String dayName(int weekday) {
    return const {
      1: 'Senin',
      2: 'Selasa',
      3: 'Rabu',
      4: 'Kamis',
      5: 'Jumat',
      6: 'Sabtu',
      7: 'Minggu',
    }[weekday]!;
  }

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  DateTime deadline(Assignment assignment) {
    return DateTime(
      now.year,
      now.month,
      now.day + assignment.daysFromNow,
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      dashboard(),
      schedulePage(),
      profilePage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: violet,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.school_rounded,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kampus Digital',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'STUDENT SPACE',
                  style: TextStyle(
                    fontSize: 9,
                    letterSpacing: 1.7,
                    color: violet,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: widget.onTheme,
            icon: Icon(
              widget.dark
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_outlined,
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
      body: IndexedStack(
        index: tab,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (value) {
          setState(() => tab = value);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view_rounded),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month_rounded),
            label: 'Jadwal',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget dashboard() {
    final todayCourses = courses
        .where((course) => course.weekday == now.weekday)
        .toList();

    final allTasks = courses
        .expand(
          (course) => course.assignments.map(
            (assignment) => {
              'course': course,
              'task': assignment,
            },
          ),
        )
        .where(
          (item) => !(item['task'] as Assignment).done,
        )
        .toList()
      ..sort(
        (a, b) => deadline(a['task'] as Assignment).compareTo(
          deadline(b['task'] as Assignment),
        ),
      );

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      children: [
        const Text(
          'Halo, Hanifatul! 👋',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            letterSpacing: -.6,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          '${dayName(now.weekday)}, ${formatDate(now)}',
          style: TextStyle(
            color: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.color
                ?.withOpacity(.65),
          ),
        ),
        const SizedBox(height: 18),
        studentHero(),
        const SizedBox(height: 23),
        sectionTitle(
          'Jadwal Hari Ini',
          todayCourses.isEmpty
              ? 'Tidak ada kelas'
              : '${todayCourses.length} kelas',
        ),
        const SizedBox(height: 10),
        if (todayCourses.isEmpty)
          emptyDayCard(now.weekday)
        else
          ...todayCourses.map(courseCard),
        const SizedBox(height: 16),
        sectionTitle('Jadwal Berikutnya', 'Mulai hari ini'),
        const SizedBox(height: 10),
        ...upcomingCourses()
            .take(3)
            .map((entry) => courseCard(entry.$1, date: entry.$2)),
        const SizedBox(height: 17),
        sectionTitle('Daftar Tugas', '${allTasks.length} belum selesai'),
        const SizedBox(height: 10),
        if (allTasks.isEmpty)
          const Text('Semua tugas sudah selesai. Keren! 🎉')
        else
          ...allTasks.take(6).map(
                (item) => taskCard(
                  item['course'] as Course,
                  item['task'] as Assignment,
                ),
              ),
      ],
    );
  }

  List<(Course, DateTime)> upcomingCourses() {
    final result = <(Course, DateTime)>[];

    for (int i = 0; i < 7; i++) {
      final date = DateTime(now.year, now.month, now.day + i);

      for (final course
          in courses.where((c) => c.weekday == date.weekday)) {
        result.add((course, date));
      }
    }

    return result;
  }

  Widget studentHero() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF33245E),
            Color(0xFF7658F5),
            Color(0xFF9D86FF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 27,
                backgroundColor: Color(0xFFE7DFFF),
                child: Icon(
                  Icons.person_rounded,
                  color: violet,
                  size: 34,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MAHASISWA AKTIF',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Hanifatul Khoir',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.verified_rounded,
                color: Color(0xFFB9F4DF),
              ),
            ],
          ),
          const SizedBox(height: 19),
          const Divider(color: Colors.white24),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(child: HeroInfo('NIM', '2495114001')),
              Expanded(
                child: HeroInfo(
                  'PROGRAM STUDI',
                  'Teknik Informatika',
                ),
              ),
              Expanded(child: HeroInfo('SEMESTER', '5')),
            ],
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String title, String action) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Text(
          action,
          style: const TextStyle(
            color: violet,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget emptyDayCard(int weekday) {
    String message;

    if (weekday == DateTime.thursday ||
        weekday == DateTime.friday) {
      message = 'Hari libur. Tidak ada perkuliahan.';
    } else if (weekday == DateTime.saturday) {
      message = 'Tidak ada mata kuliah hari ini.';
    } else {
      message = 'Belum ada jadwal kuliah untuk hari ini.';
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: const Color(0xFFECE7FF),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.event_available_rounded,
                color: violet,
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dayName(weekday),
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget courseCard(Course course, {DateTime? date}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => openCourse(course),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFECE7FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(course.icon, color: violet),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (date != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          '${dayName(date.weekday)}, ${formatDate(date)}',
                          style: const TextStyle(
                            color: violet,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    Text(
                      course.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 7),
                    detailLine(Icons.schedule_rounded, course.time),
                    const SizedBox(height: 4),
                    detailLine(
                      Icons.location_on_outlined,
                      course.room,
                    ),
                    const SizedBox(height: 4),
                    detailLine(
                      Icons.person_outline_rounded,
                      course.lecturer,
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: violet,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget detailLine(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 14, color: violet),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 11),
          ),
        ),
      ],
    );
  }

  Widget taskCard(Course course, Assignment assignment) {
    return Card(
      margin: const EdgeInsets.only(bottom: 9),
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Row(
          children: [
            Checkbox(
              value: assignment.done,
              activeColor: mint,
              onChanged: (value) {
                setState(() => assignment.done = value ?? false);
              },
            ),
            const SizedBox(width: 5),
            Expanded(
              child: InkWell(
                onTap: () => openCourse(course),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      assignment.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        decoration: assignment.done
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      course.name,
                      style: const TextStyle(
                        fontSize: 11,
                        color: violet,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Deadline: ${formatDate(deadline(assignment))}',
                      style: TextStyle(
                        fontSize: 11,
                        color: deadline(assignment)
                                    .difference(
                                      DateTime(now.year, now.month, now.day),
                                    )
                                    .inDays <=
                                2
                            ? Colors.deepOrange
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget schedulePage() {
    final visible = courses.where((course) {
      return course.name.toLowerCase().contains(search.toLowerCase()) ||
          course.lecturer.toLowerCase().contains(search.toLowerCase());
    }).toList();

    final ordered = <Course>[];

    for (int i = 0; i < 7; i++) {
      final date = DateTime(now.year, now.month, now.day + i);
      ordered.addAll(
        visible.where(
          (course) =>
              course.weekday == date.weekday &&
              !ordered.contains(course),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      children: [
        const Text(
          'Jadwal Kuliah',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'Jadwal diurutkan mulai hari ini dan seterusnya.',
          style: TextStyle(
            color: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.color
                ?.withOpacity(.65),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          onChanged: (value) => setState(() => search = value),
          decoration: InputDecoration(
            hintText: 'Cari mata kuliah atau dosen...',
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: violet,
            ),
            filled: true,
            fillColor: Theme.of(context).cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 18),
        ...List.generate(7, (i) {
          final date = DateTime(now.year, now.month, now.day + i);
          final dayCourses = ordered
              .where((course) => course.weekday == date.weekday)
              .toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 9),
                child: Row(
                  children: [
                    Text(
                      i == 0
                          ? 'HARI INI · ${dayName(date.weekday)}'
                          : '${dayName(date.weekday)} · ${formatDate(date)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: violet,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    if (date.weekday == DateTime.thursday ||
                        date.weekday == DateTime.friday)
                      const Text(
                        'LIBUR',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.orange,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                  ],
                ),
              ),
              if (dayCourses.isEmpty)
                emptyDayCard(date.weekday)
              else
                ...dayCourses.map(
                  (course) => courseCard(course, date: date),
                ),
            ],
          );
        }),
      ],
    );
  }

  Widget profilePage() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      children: [
        const Text(
          'Profil Saya',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 18),
        studentHero(),
        const SizedBox(height: 18),
        profileTile(Icons.badge_outlined, 'NIM', '2495114001'),
        profileTile(
          Icons.school_outlined,
          'Program Studi',
          'Teknik Informatika',
        ),
        profileTile(Icons.layers_outlined, 'Semester', '5'),
        profileTile(
          Icons.account_balance_outlined,
          'Universitas',
          'Universitas Hasyim Asy’ari',
        ),
        const SizedBox(height: 18),
        Card(
          child: SwitchListTile(
            title: const Text('Mode gelap'),
            subtitle: const Text('Ubah tampilan aplikasi'),
            secondary: const Icon(
              Icons.dark_mode_outlined,
              color: violet,
            ),
            value: widget.dark,
            onChanged: (_) => widget.onTheme(),
          ),
        ),
      ],
    );
  }

  Widget profileTile(IconData icon, String title, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 9),
      child: ListTile(
        leading: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFECE7FF),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(icon, color: violet),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  void openCourse(Course course) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CourseDetailPage(
          course: course,
          formatDate: formatDate,
          deadline: deadline,
          onTaskChanged: () => setState(() {}),
        ),
      ),
    );
  }
}

class CourseDetailPage extends StatefulWidget {
  final Course course;
  final String Function(DateTime) formatDate;
  final DateTime Function(Assignment) deadline;
  final VoidCallback onTaskChanged;

  const CourseDetailPage({
    super.key,
    required this.course,
    required this.formatDate,
    required this.deadline,
    required this.onTaskChanged,
  });

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  @override
  Widget build(BuildContext context) {
    final course = widget.course;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Mata Kuliah')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF33245E), Color(0xFF7658F5)],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    course.icon,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  course.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 13),
                whiteLine(
                  Icons.person_outline_rounded,
                  'Dosen: ${course.lecturer}',
                ),
                const SizedBox(height: 7),
                whiteLine(
                  Icons.schedule_rounded,
                  '${dayName(course.weekday)} · ${course.time}',
                ),
                const SizedBox(height: 7),
                whiteLine(
                  Icons.location_on_outlined,
                  course.room,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Materi Perkuliahan',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          ...course.materials.asMap().entries.map(
                (entry) => Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFFECE7FF),
                      foregroundColor: violet,
                      child: Text('${entry.key + 1}'),
                    ),
                    title: Text(
                      entry.value,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: const Icon(
                      Icons.menu_book_outlined,
                      color: violet,
                    ),
                  ),
                ),
              ),
          const SizedBox(height: 23),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Tugas Mata Kuliah',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                '${course.assignments.where((a) => !a.done).length} belum selesai',
                style: const TextStyle(
                  fontSize: 11,
                  color: violet,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...course.assignments.map(
            (assignment) => Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            assignment.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              decoration: assignment.done
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                        ),
                        Checkbox(
                          value: assignment.done,
                          onChanged: (value) {
                            setState(() {
                              assignment.done = value ?? false;
                            });
                            widget.onTaskChanged();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(assignment.description),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.event_outlined,
                          size: 16,
                          color: violet,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'Deadline: ${widget.formatDate(widget.deadline(assignment))}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: violet,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        assignment.done ? 'SELESAI' : 'BELUM SELESAI',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: assignment.done ? mint : Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Catatan: materi dan tugas pada versi ini adalah contoh '
            'yang bisa kamu ubah sesuai instruksi dosen.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  String dayName(int weekday) {
    return const {
      1: 'Senin',
      2: 'Selasa',
      3: 'Rabu',
      4: 'Kamis',
      5: 'Jumat',
      6: 'Sabtu',
      7: 'Minggu',
    }[weekday]!;
  }

  Widget whiteLine(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 17, color: Colors.white70),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

class HeroInfo extends StatelessWidget {
  final String label;
  final String value;

  const HeroInfo(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white60,
            fontSize: 9,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}