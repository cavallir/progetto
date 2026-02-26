import 'package:flutter/material.dart';



class LostConnection extends StatelessWidget{
  const LostConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Non sono riuscito",
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("a controllare l'orario",
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20,),
            Icon(
              Icons.alarm_off_rounded,
              color: Colors.redAccent,
              size: 150,
            ),
            SizedBox(height: 20,),
            Text("Verifica la tua",
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("connessione internet",
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}