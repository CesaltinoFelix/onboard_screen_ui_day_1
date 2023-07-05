import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Onboard Screen ui - day 1',
      home: OnboardScreen(),
    );
  }
}

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  final int _numPages = 3;

  List<Widget> _biuldPageIndicator() {
    List<Widget> list = [];
    for (var i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }

    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 8,
      width: isActive ? 46 : 16,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : const Color(0xFF7B51D3),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                0.1,
                0.6,
                0.7,
                0.9
              ],
                  colors: [
                Color(0xFF4F9FDB),
                Color(0xFF6780E4),
                Color(0xFF8773EE),
                Color(0xFF8E5DE4),
              ])),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => print('Pular'),
                    child: const Text(
                      'Pular',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 600,
                  child: PageView(
                    physics: const ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: [
                      onboardItem(
                        title: 'Bem-vindo(a) à EduLynx',
                        imagePath: 'assets/images/student.json',
                        content:
                            'A sua escola online de excelência educacional! Estamos empolgados em tê-lo(a) a bordo.',
                      ),
                      onboardItem(
                        title: 'Aprendizado Personalizado',
                        imagePath: 'assets/images/teaching.json',
                        content:
                            'Na EduLynx, valorizamos seu progresso individual. Aproveite recursos interativos, fóruns de discussão e feedback personalizado dos instrutores para aprimorar suas habilidades. ',
                      ),
                      onboardItem(
                        title: 'Recursos Ilimitados',
                        imagePath:
                            'assets/images/student-transparent.json',
                        content:
                            'Na EduLynx, oferecemos a você uma ampla gama de recursos ilimitados para enriquecer sua experiência de aprendizado.',
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _biuldPageIndicator(),
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        _pageController.nextPage(
                            duration: const Duration(microseconds: 500),
                            curve: Curves.ease);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _currentPage != _numPages - 1
                              ? const Text(
                                  'Seguinte',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                )
                              : const Text(
                                  'continuar',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget onboardItem({title, imagePath, content}) {
  return Padding(
    padding: const EdgeInsets.all(40.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Lottie.asset(imagePath, width: 350, height: 350),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 22),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          content,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ],
    ),
  );
}
