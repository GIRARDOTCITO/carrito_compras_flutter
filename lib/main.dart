import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../productos_agregados.dart';
import '../modelo_carrito.dart';

void main() {
  runApp(ChangeNotifierProvider(
    //Es una clase incluida en el sdk de flutter que proporciona notificaciones a los cambios a sus listeners.
    //Es una manera de encapsular el estado de tu aplicacion. Para apps muy simples, en la libreria de provider.
    //El ChangeNotifierProvider, permite una instancia hacia sus desendientes de provider
    create: (context) => Carrito(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Producto {
  //Creamos nuestro constructor, para nuestro carrito de compras definiendo cada uno de los valores que usaremos.
  late String titulo;
  late double precio;
  late String image;
  //late: hace cumplir las garantias de nuestra variable en tiempo de ejecucion y no de compilacion
  Producto({required this.titulo, required this.precio, required this.image});
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Producto> productos = [
    //Agregamos una lista, en el cual la variable productos obtendra cada uno de los valores que usaremos en nuestra pagina principal
    Producto(titulo: 'AUDIFONOS', precio: 75000.00, image: 'img/audifonos.jpg'),
    Producto(titulo: 'CÁMARA', precio: 10000.00, image: 'img/camara.jpg'),
    Producto(titulo: 'MONITOR', precio: 500000.00, image: 'img/monitor.jpg'),
    Producto(titulo: 'MOUSE', precio: 50000.00, image: 'img/mouse.jpg'),
    Producto(titulo: 'SETUP', precio: 5000000.00, image: 'img/setup.jpg'),
    Producto(titulo: 'TECLADO', precio: 120000.00, image: 'img/teclado.jpg'),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<Carrito>(builder: (context, carrito, child) {
     //LLama el provider, del runMyApp, donde cogemos la variable del carrito donde se encuentran todos nuestros productos
      return Scaffold(
        appBar: AppBar(
          //Damos estilo a nuestro carrito con un appBar en la pagina principal
          title: const Text('Carrito de Compras'),
          backgroundColor: Colors.green,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProductosAgregados()));
                    },
                  ),
                  Text(carrito.count.toString())
                  //Agregamos tanto un count como el logo del carrito de compras, para que nos lleve directo a nuestro carrito de compras.
                ],
              ),
            )
          ],
          centerTitle: true,
        ),
        body: carrito.productoxd.isEmpty
        //Nuestro carrito va a tener dos opciones, una de ellas es que tanto se agreguen productos al carrito se eliminaran de nuestra pagina principal. y asi sucesivamente
            ? const Center(
                child: Text('No tenemos productos disponibles lo sentimos!!'))
            : ListView.builder(
          //Daremos a cada una de nuestras partes del carrito formas precios imagenes, etc.`
                itemCount: carrito.productoxd.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 80,
                            height: 80,
                            child: CircleAvatar(
                              radius: 750,
                              backgroundImage: AssetImage(
                                carrito.productoxd[index].image,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 1),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Text(
                                      carrito.productoxd[index].titulo,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 6, right: 7),
                                    child: Text(
                                      '  Precio: \$${carrito.productoxd[index].precio.toString()}',
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              carrito.add(carrito.productoxd[index]);
                            },
                            //damos el icono de agregar a nuestro producto y se enviara a nuestro carrito de compras.
                            icon: const Icon(Icons.add_circle),
                          )
                        ],
                      ),
                    ),
                    /*
            leading: Image.asset(productos[index].image),
            title: Text(productos[index].titulo),
            trailing: Icon(Icons.add_circle ),
            onTap: (){
              carrito.add(productos[index]);
            },
*/
                  );
                },
              ),
      );
    });
  }
}
