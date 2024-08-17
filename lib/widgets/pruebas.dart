import 'package:flutter/material.dart';

class ModalTry extends StatelessWidget {
  const ModalTry({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {
      'gameName': 'Game Name',
      'gameImage': 'https://via.placeholder.com/150',
      'summary': 'Summary of the game',
    };
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modal Try'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            mobileModal(context, data);
          },
          child: const Text('Abrir Modal'),
        ),
      ),
    );
  }

  Future<dynamic> mobileModal(BuildContext context, Map<String, dynamic> data) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 500,
          child: Center(
            child: Row(
              children: [
                Text(data['gameName']),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text('Modal BottomSheet'),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cerrar Modal'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
