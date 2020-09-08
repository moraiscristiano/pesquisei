import 'package:flutter/material.dart';
import 'package:flutter_crud/views/fragment/Fragment.dart';

import '../cidade/cidade_list.dart';

class Home extends StatefulWidget {
  final String title;

   Home({Key key, this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  String curTitle = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(curTitle),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('HOME'),
              selected: 0 == _selectedIndex,
              onTap: () {
                _onSelectItem(0);
              },
            ),
            ListTile(
              title: Text('CIDADES'),
              selected: 1 == _selectedIndex,
              onTap: () {
                _onSelectItem(1);
              },              
            ),
            ListTile(
              title: Text('PESQUISA'),
              selected: 2 == _selectedIndex,
              onTap: () {
                _onSelectItem(2);
              },
              
            ),
            ListTile(
              title: Text('SINCRONIZAR'),
              selected: 3 == _selectedIndex,
              onTap: () {
                _onSelectItem(3);
              },
              
            ),
          ],
        ),
      ),
      body: _getDrawerItem(_selectedIndex),
    );
  }

  _getDrawerItem(int pos) {
    switch (pos) {
      case 0: // Home
        return Fragment("");
      case 1: // Cidades
        return CidadeList();
      case 2: // Pesquisa
        return Fragment("");
      case 3: // Sincronizar
        return Fragment("");
    }
  }

  _onSelectItem(int index) {
    
     switch (index) {
      case 0: // Home
        curTitle = 'HOME';
        break;
      case 1: // Cidades
        curTitle = 'CIDADES';
        break;
      case 2: // Pesquisa
        curTitle = 'PESQUISA';
        break;
      case 3: // Sincronizar
        curTitle = 'SINCRONIZAR';
        break;
    }

    
    setState(() => _selectedIndex = index);
    Navigator.of(context).pop();
  }
}


