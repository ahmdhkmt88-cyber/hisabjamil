import 'package:flutter/material.dart';

void main() {
  runApp(const JamilCalculatorApp());
}

class JamilCalculatorApp extends StatelessWidget {
  const JamilCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'حساب الجمل الكبير',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        // تم إرجاع خلفية الصفحة الرئيسية للون الأبيض
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 4,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();

  int _firstScore = 0;
  int _secondScore = 0;
  int _totalScore = 0;

  static const Map<String, int> _abjadValues = {
    'أ': 1,
    'ا': 1,
    'إ': 1,
    'آ': 1,
    'ء': 1,
    'ب': 2,
    'ج': 3,
    'د': 4,
    'ه': 5,
    'ة': 5,
    'و': 6,
    'ز': 7,
    'ح': 8,
    'ط': 9,
    'ي': 10,
    'ى': 10,
    'ك': 20,
    'ل': 30,
    'م': 40,
    'ن': 50,
    'س': 60,
    'ع': 70,
    'ف': 80,
    'ص': 90,
    'ق': 100,
    'ر': 200,
    'ش': 300,
    'ت': 400,
    'ث': 500,
    'خ': 600,
    'ذ': 700,
    'ض': 800,
    'ظ': 900,
    'غ': 1000,
  };

  @override
  void dispose() {
    _firstNameController.dispose();
    _secondNameController.dispose();
    super.dispose();
  }

  int _calculateJamil(String text) {
    return text.characters.fold(0, (sum, char) {
      return sum + (_abjadValues[char] ?? 0);
    });
  }

  void _processCalculation() {
    FocusScope.of(context).unfocus();

    setState(() {
      _firstScore = _calculateJamil(_firstNameController.text);
      _secondScore = _calculateJamil(_secondNameController.text);
      _totalScore = _firstScore + _secondScore;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'حاسبة الجمل الكبير',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // الخانة الأولى (خلفية بيج هادئة لتبرز فوق الأبيض)
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'الاسم الأول',
                  labelStyle: const TextStyle(color: Colors.purple),
                  prefixIcon: const Icon(Icons.person, color: Colors.purple),
                  fillColor: const Color(0xFFFAF6F0), // لون بيج هادئ
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.purple,
                      width: 2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // الخانة الثانية
              TextField(
                controller: _secondNameController,
                decoration: InputDecoration(
                  labelText: 'الاسم الثاني',
                  labelStyle: const TextStyle(color: Colors.purple),
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Colors.purple,
                  ),
                  fillColor: const Color(0xFFFAF6F0), // لون بيج هادئ
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.purple,
                      width: 2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 35),

              // زر الحساب
              ElevatedButton.icon(
                onPressed: _processCalculation,
                icon: const Icon(Icons.calculate),
                label: const Text('احسب الجمل'),
              ),

              const SizedBox(height: 40),

              // بطاقة عرض النتائج بخلفية بيج دافئة
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF6F0), // خلفية بيج كريمية للنتائج
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withValues(alpha: 0.12),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildResultRow('جمل الاسم الأول:', _firstScore),
                    const Divider(height: 25),
                    _buildResultRow('جمل الاسم الثاني:', _secondScore),
                    const Divider(
                      height: 25,
                      thickness: 1.5,
                      color: Colors.purple,
                    ),
                    _buildResultRow(
                      'المجموع الكلي:',
                      _totalScore,
                      isTotal: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultRow(String title, int value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.purple : Colors.black87,
          ),
        ),
        Text(
          '$value',
          style: TextStyle(
            fontSize: isTotal ? 24 : 18,
            fontWeight: FontWeight.bold,
            color: isTotal ? Colors.deepPurple : Colors.purple,
          ),
        ),
      ],
    );
  }
}
