import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejemplo de Cálculos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _kwController = TextEditingController();
  final TextEditingController _precioArticuloController = TextEditingController();

  double _pagoElectricidad = 0.0;
  double _precioConDescuento = 0.0;
  double _precioFinal = 0.0;

  void calcularPagoElectricidad() {
    double kw = double.tryParse(_kwController.text) ?? 0.0;
    double costoPorKw = 5.79; // Puedes cambiar el costo por KW aquí
    setState(() {
      _pagoElectricidad = kw * costoPorKw;
    });
  }

  void calcularPrecioArticulo() {
    double precioOriginal = double.tryParse(_precioArticuloController.text) ?? 0.0;
    setState(() {
      _precioConDescuento = precioOriginal * 0.8; // 20% de descuento
      _precioFinal = _precioConDescuento * 1.15; // 15% de IVA sobre el precio con descuento
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cálculos CLS y Artículo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Cálculo de Pago por Consumo de Energía Eléctrica',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: _kwController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ingrese consumo en KW',
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: calcularPagoElectricidad,
                child: const Text('Calcular Pago'),
              ),
              const SizedBox(height: 10),
              Text('Pago por consumo: \$${_pagoElectricidad.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16)),
              const Divider(height: 40),

              const Text('Cálculo de Precio con Descuento e IVA',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: _precioArticuloController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ingrese precio del artículo',
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: calcularPrecioArticulo,
                child: const Text('Calcular Precio Final'),
              ),
              const SizedBox(height: 10),
              Text('Precio con descuento: \$${_precioConDescuento.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16)),
              Text('Precio final con IVA: \$${_precioFinal.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}