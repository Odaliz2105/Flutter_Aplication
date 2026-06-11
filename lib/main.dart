import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Generador de Números Primos',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const PrimeNumbersPage(),
    );
  }
}

class PrimeNumbersPage extends StatefulWidget {
  const PrimeNumbersPage({super.key});

  @override
  State<PrimeNumbersPage> createState() => _PrimeNumbersPageState();
}

class _PrimeNumbersPageState extends State<PrimeNumbersPage> {
  final List<int> _primos = [2];

  bool esPrimo(int numero) {
    if (numero < 2) return false;

    for (int i = 2; i * i <= numero; i++) {
      if (numero % i == 0) {
        return false;
      }
    }

    return true;
  }

  void agregarPrimo() {
    setState(() {
      int siguiente = _primos.last + 1;

      while (!esPrimo(siguiente)) {
        siguiente++;
      }

      _primos.add(siguiente);
    });
  }

  void eliminarPrimo() {
    setState(() {
      if (_primos.length > 1) {
        _primos.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: const Text(
          'Generador de Números Primos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.calculate_rounded,
                    size: 50,
                    color: Colors.white,
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Cantidad de números primos',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    '${_primos.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: GridView.builder(
                itemCount: _primos.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        _primos[index].toString(),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'agregar',
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            tooltip: 'Agregar número primo',
            onPressed: agregarPrimo,
            child: const Icon(Icons.add),
          ),

          const SizedBox(height: 12),

          FloatingActionButton(
            heroTag: 'eliminar',
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            tooltip: 'Eliminar último primo',
            onPressed: eliminarPrimo,
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}