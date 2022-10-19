import 'package:flutter/material.dart';
import '../main.dart';

class Carrito extends ChangeNotifier {
  //Esta es la parte mas importante de nuestro carrito, aqui se encuentra la funcionalidad,
  //lo que hacemos primero es crear nuestra clase y extenderla deacuerdo a nuestro runMyApp, donde se encuetra nuestro ChangeNotifier
  final List<Producto> _productos = [];
  //creamos un arreglo vacio, donde va a contener cada uno de los productos que agregemos a nuestro carrito de compras
  final List<Producto> _producto = [
    //Agregamos la variable de producto, donde a tanto tomar los productos donde se mostrara en nuestra lista de productos
    //y tambien la funcionalidad de eliminar de nuestro carrito de compras para que no se multipliquen
    Producto(titulo: 'AUDIFONOS', precio: 75000.00, image: 'img/audifonos.jpg'),
    Producto(titulo: 'CÁMARA', precio: 10000.00, image: 'img/camara.jpg'),
    Producto(titulo: 'MONITOR', precio: 500000.00, image: 'img/monitor.jpg'),
    Producto(titulo: 'MOUSE', precio: 50000.00, image: 'img/mouse.jpg'),
    Producto(titulo: 'SETUP', precio: 5000000.00, image: 'img/setup.jpg'),
    Producto(titulo: 'TECLADO', precio: 120000.00, image: 'img/teclado.jpg'),
  ];
  double _preciototal = 0.0;
  //Creamos una variable la cual inicia en 0.0 donde tendremos el precio total de cada producto

  void add(producto) {
    //Esta funcion, tiene el objetivo de agregar productos a nuestro carrito de compras, y tambien elimina los productos agregados al carrito de compras para que no se dupliquen
    //tambien sumamos cada uno de los productos que agregamos al carrito de compras, y esto lo notificara en el changenotifier
    _producto.remove(producto);
    _productos.add(producto);
    _preciototal += producto.precio;
    notifyListeners();
  }

  void remove(producto) {
    //Este boton tiene la funcionalidad de eliminar los productos que no queremos en nuestro carrito de compras,
    //y se agregan a nuestra pagina principal de productos, tambien resta los productos que se van quitando de nuestra factura principal
    _producto.add(producto);
    _preciototal -= producto.precio;
    _productos.remove(producto);
    notifyListeners();
  }

  int get count {
    return _productos.length;
  }

  double get preciototal {
    return _preciototal;
  }

  List<Producto> get productostienda {
    return _productos;
  }

  List<Producto> get productoxd {
    return _producto;
  }
  //retornamos cada una de nuestras variables tanto donde se cuentan, como tambien en su precio y en la lista principal donde se encuentran nuestros productos.
}
