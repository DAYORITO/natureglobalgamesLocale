import 'package:flutter/material.dart';
import 'package:natureglobalgames/services/apiservice.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NatureGlobalGames',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class AppState extends ChangeNotifier {}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final apiservice = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NatureGlobalGames'),
      ),
      body: SafeArea(
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
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        int crossAxisCount = (constraints.maxWidth / 250).floor();
                        double childAspectRatio = constraints.maxWidth / (constraints.maxHeight / 5);
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1,
                          ),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        data[index]['gameImage'],
                                        width: double.infinity,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    ListTile(
                                      
                                      title: Text(data[index]['gameName'], maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold),),
                                      subtitle: Text(data[index]['summary'],
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,),
                                      // trailing: Text(data[index]['announcementYea'] ?? 'Released'),
                                    ),
                                    
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    );
                  }
                }
              })),
    );
  }
}
