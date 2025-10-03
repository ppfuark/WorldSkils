import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';  // Para gerenciar o caminho do banco de dados

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializando o banco de dados
  final dbInstance = initializeDatabase();

  runApp(MyApp(dbInstance: dbInstance));
}

// Função para inicializar o banco de dados
Future<Database> initializeDatabase() async {
  // Defina o caminho para o banco de dados
  String path = join(await getDatabasesPath(), './example.db');
    print("Banco de dados será criado em: $path");


  // Abrindo o banco de dados
  return openDatabase(
    path,
    onCreate: (db, version) {
      // Criando a tabela 'products' se ela não existir
      return db.execute(
        'CREATE TABLE products(id INTEGER PRIMARY KEY, name TEXT, price REAL)',
      );
    },
    version: 1,
  );
}

class MyApp extends StatelessWidget {
  final Future<Database> dbInstance;

  const MyApp({super.key, required this.dbInstance});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(dbInstance: dbInstance),
    );
  }
}

class HomePage extends StatefulWidget {
  final Future<Database> dbInstance;

  const HomePage({super.key, required this.dbInstance});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  List<Map<String, dynamic>> _products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final db = await widget.dbInstance;
    final List<Map<String, dynamic>> products = await db.query('products');
    setState(() {
      _products = products;
    });
  }

  Future<void> _addProduct() async {
    final name = _nameController.text;
    final price = double.tryParse(_priceController.text);

    if (name.isNotEmpty && price != null) {
      final db = await widget.dbInstance;
      await db.insert(
        'products',
        {'name': name, 'price': price},
        conflictAlgorithm: ConflictAlgorithm.replace,  // Se houver conflito, substitui o produto
      );
      _loadProducts();  // Recarrega a lista de produtos
    } else {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(SnackBar(
        content: Text('Por favor, preencha todos os campos corretamente.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tela de Monitoramento banco de dados")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome do Produto'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Preço do Produto'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addProduct,
              child: Text('Adicionar Produto'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  return ListTile(
                    title: Text(product['name']),
                    subtitle: Text('Preço: \$${product['price'].toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
