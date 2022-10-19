import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../modelo_carrito.dart';


class ProductosAgregados extends StatefulWidget {
  const ProductosAgregados({super.key});

  @override
  State<ProductosAgregados> createState() => _ProductosAgregadosState();
}
//Crearemos nuestro carrito de compras, donde se agregaran todos los productos que estan en nuestra lista
class _ProductosAgregadosState extends State<ProductosAgregados> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Carrito>(
      builder: (context, carrito, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              //Agregamos un contador de factura, donde nos mostrara cada uno de los valores y el total de nuestra factura
                'Productos agregados  -  Precio total = \$${carrito.preciototal}'),
            backgroundColor: Colors.green,
            centerTitle: true,
          ),

          body: carrito.productostienda.isEmpty
          //damos a opcion en caso de que no haya ningun producto agregado al carrito aparece un mensaje de no agregado productos
              ? const Center(
                  child: Text(
                    'No has agregado ningun producto',
                  ),
                )
              : ListView.builder(
                  itemCount: carrito.productostienda.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //damos tanto a nuestro carrito a los productos agregados estilo y funcionalidad de eliminar,
                            //para que funcione cuando queramos eliminar un producto
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: CircleAvatar(
                                radius: 750,
                                backgroundImage: AssetImage(
                                    carrito.productostienda[index].image),
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
                                      padding:
                                          const EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        carrito.productostienda[index].titulo,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 6, right: 7),
                                      child: Text(
                                        '  Precio: \$${carrito.productostienda[index].precio.toString()}',
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                carrito.remove(carrito.productostienda[index]);
                              },
                              icon: const Icon(Icons.delete, color: Colors.red),
                              //Agregamos el icono de eliminar productos de nuestra tienda
                            )
                          ],
                        ),
                      ),

                      /* child: ListTile(
                    leading: Image.asset(carrito.productostienda[index].image),
                    title: Text(carrito.productostienda[index].titulo),
                    trailing: IconButton( icon: Icon(Icons.delete),
                    onPressed: (){
                      carrito.remove(carrito.productostienda[index]);
                    },
                    ),
                  ),
                  */
                    );
                  },
                ),

          //default flex is 2
        );
      },
    );
  }
}
