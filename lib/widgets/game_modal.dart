import 'package:flutter/material.dart';
import 'package:natureglobalgames/main.dart';
import 'package:provider/provider.dart';

class GameModal extends StatelessWidget {
  const GameModal(
      {super.key,
      required this.data,
      required this.gameName,
      required this.widthcard});
  final double widthcard;
  final Map<String, dynamic> data;
  final String gameName;

  @override
  Widget build(BuildContext context) {
    final screenSize = Provider.of<AppState>(context);
    return SizedBox(
      height: screenSize.height * 0.8,
      width: widthcard * 0.4,
      child: Center(
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: screenSize.height > 800 ? 1.4 : 2.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  data['gameImage'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Center(
                      child: Text(
                        data['gameName'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    CustomEnrichedText(
                        data: data, field: 'Resumen', arrayText: 'summary'),
                    const SizedBox(height: 2),
                    CustomEnrichedText(
                        data: data, field: 'Generos', arrayText: 'genre'),
                    const SizedBox(height: 2),
                    CustomEnrichedText(
                        data: data,
                        field: 'Desarrolladora',
                        arrayText: 'developer'),
                        const SizedBox(height: 2),
                    CustomEnrichedText(
                        data: data, field: 'Año', arrayText: 'announcementYear'),

                     Center(child: ElevatedButton(onPressed: () {}, child: const Text('Jugar', style: TextStyle(fontWeight: FontWeight.bold,),)))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomEnrichedText extends StatelessWidget {
  const CustomEnrichedText(
      {super.key,
      required this.data,
      required this.field,
      required this.arrayText});
  final Map<String, dynamic> data;
  final String field;
  final String arrayText;
  final int? maxLines = 5;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '${field.isEmpty ? 'Agregar texto: ' : field}: ',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: '${data[arrayText] ?? 'Sin información'}',
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ],
      ),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
