import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late SMIBool homeTrigger;
  List<RiveAsset> bottoms = [
    RiveAsset(
      ImageUrl.animeRive,
      artBoard: 'HOME',
      stateMachineName: 'HOME_Interactivity',
      title: 'Home',
    ),
    RiveAsset(
      ImageUrl.animeRive,
      artBoard: 'SEARCH',
      stateMachineName: 'SEARCH_Interactivity',
      title: 'Search',
    ),
    RiveAsset(
      ImageUrl.animeRive,
      artBoard: 'BELL',
      stateMachineName: 'BELL_Interactivity',
      title: 'Chat',
    ),
    RiveAsset(
      ImageUrl.animeRive,
      artBoard: 'TIMER',
      stateMachineName: 'TIMER_Interactivity',
      title: 'Timer',
    ),
  ];
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.zero,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                bottoms.length,
                (index) => GestureDetector(
                  onTap: () {
                    bottoms[index].input!.change(true);
                    Future.delayed(const Duration(seconds: 1), () {
                      bottoms[index].input!.change(false);
                    });
                  },
                  child: SizedBox(
                    width: 36,
                    height: 35,
                    child: RiveAnimation.asset(
                      bottoms.first.src,
                      artboard: bottoms[index].artBoard,
                      onInit: (art) {
                        StateMachineController controller = RiveUtils.getRiveController(
                          art,
                          stateMachineName: bottoms[index].stateMachineName,
                        );
                        bottoms[index].input = controller.findSMI('active'); //controller.findInput('Trigger1') as riv.SMIBool;
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class RiveUtils {
  static StateMachineController getRiveController(Artboard artboard, {stateMachineName = 'State Machine 1'}) {
    StateMachineController? controller = StateMachineController.fromArtboard(artboard, stateMachineName);
    artboard.addController(controller!);
    return controller;
  }
}

class RiveAsset {
  final String artBoard, stateMachineName, title, src;
  late SMIBool? input;
  RiveAsset(
    this.src, {
    required this.artBoard,
    required this.stateMachineName,
    required this.title,
    this.input,
  });
  set setInput(SMIBool status) {
    input = status;
  }
}

class MyTheme {
  static const Color primary = Color(0XFF3B78EB);
  static const Color black = Color(0XFF171717);
  static const Color textColor = Color(0XFF171717);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color dividerColor = Color(0xFFDBDBDB);
  static const Color borderColor = Color(0xFFE9E9E9);
  static const Color iconColorBlack = Color(0xFF272A3E);
  static const Color textFieldColor = Color(0xFFF3F3F3);
  static const Color primaryDark = Color(0xFF053A9C);
  static const Color containerColor = Color(0xFF3B78EB);
  static const Color blackTextColor = Color(0xFF070707);
}

class ImageUrl {
  //-------------------images------------------------

  static const logo = 'assets/images/logo.png';
  static const splash = 'assets/images/splash_image.png';
  static const dummyImage = 'assets/images/dummy_image.png';

  //-------------------svg-icons------------------------

  static const hamIcons = 'assets/svg_icons/ham.svg';

  //-------------------lottie------------------------

  static const loop = 'assets/lottie/loop.json';

//-------------------rive------------------------

  static const arrowRive = 'assets/rives/arrow.riv';
  static const homeRive = 'assets/rives/home.riv';
  static const animeRive = 'assets/rives/anime.riv';
}
