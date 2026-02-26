import 'package:flutter/material.dart';
import '../utilities/globals.dart';
import 'ConsiglioMese.dart';

class ConsigliPage extends StatefulWidget {
  final List<String> classi;
  const ConsigliPage({super.key, required this.classi});

  @override
  State<ConsigliPage> createState() => _ConsigliPageState(classi: classi);
}

class _ConsigliPageState extends State<ConsigliPage> {
  final List<String> classi;
  final List<String> classiEmpty = <String>[];

  _ConsigliPageState({required this.classi});

  @override
  Widget build(BuildContext context) {


    for(int i=0; i<classi.length; i++){
      if(classi[i].length > 2){
        String str = classi[i].substring(0,2);
        classi[i] = str;
      }
    }

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'CONSIGLI DI CLASSE',
            style: TextStyle(
                fontSize: 26.0, fontStyle: FontStyle.italic, color: Colors.green,
            ),
          ),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'I TUOI',
                //icon: Icon(Icons.cloud_outlined),
              ),
              Tab(
                text: 'TUTTI',
                //icon: Icon(Icons.beach_access_sharp),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: Globals.consigli.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child:GestureDetector(
                      onTap:  () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConsiglioMese(
                              mese: Globals.consigli[index].mese.toUpperCase(),
                              index: index,
                              filtro: classi,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 45,
                        color: Colors.green,
                        child: Center(
                          child: Text(
                            Globals.consigli[index].mese.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
              ),
            ),
            Center(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: Globals.consigli.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child:GestureDetector(
                      onTap:  () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConsiglioMese(
                              mese: Globals.consigli[index].mese.toUpperCase(),
                              index: index,
                              filtro: classiEmpty,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 45,
                        color: Colors.green,
                        child: Center(
                          child: Text(
                            Globals.consigli[index].mese.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
              ),
            ),
          ],
        ),
      ),
    );
  }}
