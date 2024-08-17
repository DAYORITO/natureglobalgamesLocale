import 'package:flutter/material.dart';
import 'package:natureglobalgames/main.dart';
import 'package:natureglobalgames/services/apiservice.dart';
import 'package:natureglobalgames/widgets/games_list.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final apiservice = ApiService();
  late Size _screenSize;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _screenSize = MediaQuery.of(context).size;
      Provider.of<AppState>(context, listen: false).setSize(_screenSize);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double titlesize = screenWidth * 0.05;
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Provider.of<AppState>(context, listen: false)
                      .updateTheme(false);
                },
                icon: const Icon(Icons.light_mode, color: Colors.white)),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ))
          ],
          title: Text(
            'NaturalGlobalGames',
            style: TextStyle(
                color: Colors.white,
                fontSize: titlesize * 0.5 > 15 ? 15 : titlesize * 0.5,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  opacity: 1,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.darken),
                  image: Image.asset('dawn1.jpg').image,
                  fit: BoxFit.cover)),
          child: FutureBuilder(
              future: apiservice.fetchData('api/Games'),
              builder: (builderContext, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    final data = snapshot.data as List<Map<String, dynamic>>;
                    return SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: _screenSize.height * 0.5,
                              width: _screenSize.width,
                              child: MainHeader(
                                  screenSize: _screenSize, titlesize: titlesize),
                            ),
                            const SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: Text(
                                'Explora',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            ListGames(
                                data: data,
                                widthcard: screenWidth,
                                calculateidealwidth: 2),
                            // una serie de textos para probar la extension de la pantalla
                            Container(
                              height: 200,
                              width: double.infinity,
                              color: Colors.red,
                              child: const Center(
                                child: Text('Una seccion'),
                              ),
                            ),
                            Container(
                              height: 200,
                              width: double.infinity,
                              color: Colors.blue,
                              child: const Center(
                                child: Text('Otra seccion'),
                              ),
                            ),
                            Container(
                              height: 200,
                              width: 200,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }
              }),
        ),
      );
    });
  }
}

class MainHeader extends StatelessWidget {
  const MainHeader({
    super.key,
    required Size screenSize,
    required this.titlesize,
  }) : _screenSize = screenSize;

  final Size _screenSize;
  final double titlesize;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: 30,
        right: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            width: _screenSize.width * 0.5,
            height: _screenSize.height * 0.5,
            child: Image.asset('dawn1.jpg',
             fit: BoxFit.cover),
          ),
        ),
      ),
      Positioned(
        top: 120,
        left: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenidos a NatureGlobalGames',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: titlesize > 30 ? 30 : titlesize,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Juegos de calidad para todos',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: titlesize * 0.5 > 15 ? 15 : titlesize * 0.5,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ]);
  }
}
