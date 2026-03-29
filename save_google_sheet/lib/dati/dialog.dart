import 'package:flutter/material.dart';

// Funzione per il feedback di inserimento/modifica
Future<void> showFeedbackDialog(BuildContext context, bool success) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          success ? 'Operazione Riuscita' : 'Errore!',
          style: TextStyle(color: success ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              success ? Icons.check_circle_outline : Icons.error_outline,
              size: 80.0,
              color: success ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 10),
            Text(success ? "Dati salvati con successo!" : "Qualcosa è andato storto."),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
}