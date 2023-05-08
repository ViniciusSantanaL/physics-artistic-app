import 'dart:async';

import 'package:flutter/material.dart';
import 'calculator.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Movimento Circular',
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  Offset center = Offset.zero;
  // Variáveis a respeito da bolinha
  Offset position = Offset.zero;
  late double postVertical;
  double velocityInit = 50;
  double raio = 100;
  late double angularVelocity = velocityInit / raio;
  double time = 0.05;

  double velocity = 10;

  @override
  void initState() {
    super.initState();
    // Ao iniciar o estado da página, chama nosso método timer
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    // Centro setado no centro da tela
    center = Offset(sizeScreen.width / 2, sizeScreen.height / 2);

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: CustomPaint(
              /* Nosso Painter que se encarrega de desenhar uma bolinha em position, 
                tomando como centro a variável center */
              painter: Painter(center, position, center, position),
              child: const SizedBox(
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Slider(
                value: velocityInit,
                max: 100,
                divisions: 10,
                label: velocityInit.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    velocityInit = value;
                  });
                },
              ),
              Center(
                child: ElevatedButton(
                  child: Text("start"),
                  onPressed: () {
                    this.timer(sizeScreen);
                  },
                ),
              )
            ],
          )),
        ],
      )),
    );
  }

  void timer(Size size) {
    setState(() {});
    /* Após 20s ele chama setState (que atualiza a tela) atualizando a posição da bolinha */
    var timer = Timer.periodic(Duration(milliseconds: 50), (Timer t) {
      setState(() {
        time += 0.05;
        Calculator calc = Calculator(time, raio, angularVelocity);

        position = calc.positionCircumferential();
      });

      // Chama a si mesmo noR
    });
    timer;
  }
}

class Painter extends CustomPainter {
  final Offset center;
  final Offset position;

  Offset posterior;

  Painter(this.center, this.position, this.anterior, this.posterior);
  Offset anterior = Offset.zero;
  @override
  void paint(Canvas canvas, Size size) {
    // Seta o centro do canvas como o centro recebido como argumento
    canvas.translate(center.dx, center.dy);

    Paint pencil = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // Desenha um círculo de raio 5 na posição recebida
    canvas.drawCircle(position, 10, pencil);
    canvas.drawLine(Offset.zero, position, pencil);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
