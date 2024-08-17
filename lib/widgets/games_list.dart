import 'package:flutter/material.dart';
import 'package:natureglobalgames/main.dart';
import 'package:provider/provider.dart';
import 'game_modal.dart';

class ListGames extends StatelessWidget {
  final double calculateidealwidth;
  const ListGames({
    super.key,
    required this.data,
    required this.widthcard,
    required this.calculateidealwidth,
  });

  final List<Map<String, dynamic>> data;
  final double widthcard;
  

  @override
  Widget build(BuildContext context) {
    final screenSize = Provider.of<AppState>(context);
    return Center(
      child: AspectRatio(
        aspectRatio: widthcard > 950
            ? 5.7
            : widthcard < 600
                ? 3.9
                : widthcard < 350
                    ? 1
                    : 3.5,
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final hovered = ValueNotifier(false);
                  return MouseRegion(
                    onEnter: (_) { hovered.value = true;},
                    onExit: (_) {hovered.value = false;
                    },
                    child: GestureDetector(
                      onTap: () {
                        widthcard > 1000
                            ? desktopmodal(context, index)
                            : mobileModal(context, data[index], {
                                'height': screenSize.height,
                                'width': screenSize.width
                              });
                      },
                      child: ValueListenableBuilder<bool>(
                        valueListenable: hovered,
                        builder: (context, value, child) => Transform.scale(
                          scale: value ? 1.1 : 1,
                          child: AspectRatio(
                            aspectRatio: widthcard < 600 ? 1.2 : 1.50,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1.8,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        data[index]['gameImage'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        data[index]['gameName'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                      ),
                      ),
                    ),
                  );
                
              },
            ),
          );
        }),
      ),
    );
  }

  Future<Object?> desktopmodal(BuildContext context, int index) {
    return showGeneralDialog(
        context: context,
        barrierLabel: "Modal",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, _, __) {
          return GameModal(
              widthcard: widthcard,
              data: data[index],
              gameName: data[index]['gameName']);
        },
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1).animate(animation),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1).animate(animation),
              child: AlertDialog(
                content: child,
              ),
            ),
          );
        });
  }

  Future<dynamic> mobileModal(BuildContext context, Map<String, dynamic> data,
      Map<String, dynamic> screenSize) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: screenSize['height'] * 0.8,
          child: Center(
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 2.5,
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
                      children: [
                        Center(
                          child: Text(
                            data['gameName'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 2),
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
                            data: data,
                            field: 'Año',
                            arrayText: 'announcementYear'),
                        Center(
                            child: ElevatedButton(
                                onPressed: () {},
                                child: const Text(
                                  'Jugar',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
