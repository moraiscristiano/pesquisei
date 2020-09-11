import 'package:flutter/material.dart';
import 'package:flutter_crud/views/bairro/bairro_list.dart';
import 'package:flutter_crud/views/fragment/fragment.dart';
import 'package:flutter_crud/views/sincronize/sincronize.dart';

import '../cidade/cidade_list.dart';

class Home extends StatefulWidget {
  final String title;

  Home({Key key, this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  String curTitle = 'Home';

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
              title: Text('Home'),
              selected: 0 == _selectedIndex,
              onTap: () {
                _onSelectItem(0);
              },
            ),
            ListTile(
              title: Text('Cidades'),
              selected: 1 == _selectedIndex,
              onTap: () {
                _onSelectItem(1);
              },
            ),
            ListTile(
              title: Text('Bairros'),
              selected: 1 == _selectedIndex,
              onTap: () {
                _onSelectItem(4);
              },
            ),
            ListTile(
              title: Text('Pesquisa'),
              selected: 2 == _selectedIndex,
              onTap: () {
                _onSelectItem(2);
              },
            ),
            ListTile(
              title: Text('Sincronizar'),
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
        return SincronizePage();
      case 4: // Sincronizar
        return BairroList();
    }
  }

  _onSelectItem(int index) {
    switch (index) {
      case 0: // Home
        curTitle = 'Home';
        break;
      case 1: // Cidades
        curTitle = 'Cidades';
        break;
      case 2: // Pesquisa
        curTitle = 'Pesquisa';
        break;
      case 3: // Sincronizar
        curTitle = 'Sincronizar';
        break;
      case 4: // Sincronizar
        curTitle = 'Bairros';
        break;
    }

    setState(() => _selectedIndex = index);
    Navigator.of(context).pop();
  }
}
