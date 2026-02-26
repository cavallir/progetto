import 'package:flutter/material.dart';

import '../utilities/globals.dart';

class ConsiglioMese extends StatefulWidget {
  final String mese;
  final int index;
  final List<String> filtro;
  const ConsiglioMese({super.key, required this.mese, required this.index, required this.filtro});

  @override
  State<ConsiglioMese> createState() => _ConsiglioMeseState(mese: mese, index: index, filtro: filtro);
}

class _ConsiglioMeseState extends State<ConsiglioMese> {
  final String mese;
  final int index;
  final List<String> filtro;
  _ConsiglioMeseState({required this.mese, required this.index, required this.filtro});

  bool checkClasse(int index, int idx){
    String classe;
    /*if(Globals.consigli[index].consigli[idx].classe.length <= 2){
      classe = Globals.consigli[index].consigli[idx].classe;
    } else {*/
      //classe = Globals.consigli[index].consigli[idx].classe.substring(0,2);
   // }

    bool check = false;
    for(int i=0; i<filtro.length; i++){
      if(filtro[i] == Globals.consigli[index].consigli[idx].classe.substring(0,2) ){
       return true;
      }
    }
    return false;
  }

  Widget? getConsiglio(int index, int idx){
    String classe = Globals.consigli[index].consigli[idx].classe;
    bool check = false;
    for(int i=0; i<filtro.length; i++){
      if(filtro[i] == classe ){
        check = true;
        break;
      }
    }

    if(check) {
      return Padding(
        padding: const EdgeInsets.all(5),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            height: 80,
            color: Colors.green,
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    Globals.consigli[index].consigli[idx].data,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    Globals.consigli[index].consigli[idx].orario,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    Globals.consigli[index].consigli[idx].classe,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              )
            ),
          ),
        ),
      );
     } else {
      return null;
    }
  }

  List<Widget> list = <Widget>[];

  fillList(){
    if(filtro.isEmpty){
      for(int idx = 0; idx < Globals.consigli[index].consigli.length; idx++){
        list.add( Padding(
          padding: const EdgeInsets.all(5),
          child: GestureDetector(
            onTap: () {},
            child: Container(
              height: 80,
              color: Colors.green,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      Globals.consigli[index].consigli[idx].data,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      Globals.consigli[index].consigli[idx].orario,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      Globals.consigli[index].consigli[idx].classe,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
              ),
            ),
          ),
        ));
      }
    } else {
      for(int idx = 0; idx < Globals.consigli[index].consigli.length; idx++){
        if(checkClasse(index, idx)){
          list.add( Padding(
            padding: const EdgeInsets.all(5),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 80,
                color: Colors.green,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        Globals.consigli[index].consigli[idx].data,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        Globals.consigli[index].consigli[idx].orario,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        Globals.consigli[index].consigli[idx].classe,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    fillList();
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: Text(mese,
        style: const TextStyle(color: Colors.green),),),
        body:  Center(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: list.length,
              itemBuilder: (BuildContext context, int idx) {
                return list[idx];
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            ),
          ),
        ),
    );
  }

  Widget _build(BuildContext context) {
  return DefaultTabController(
    initialIndex: 0,
    length: 2,
    child: Scaffold(
      appBar: AppBar(title: Text(mese),),
      body:  Center(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: Globals.consigli[index].consigli.length,
          itemBuilder: (BuildContext context, int idx) {
            return Padding(
              padding: const EdgeInsets.all(5),
              child:GestureDetector(
                onTap:  () {},
                child: Container(
                  height: 80,
                  color: Colors.green,
                  child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            Globals.consigli[index].consigli[idx].data,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            Globals.consigli[index].consigli[idx].orario,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            Globals.consigli[index].consigli[idx].classe,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
          ),
        ),
      ),
    );
  }

}
