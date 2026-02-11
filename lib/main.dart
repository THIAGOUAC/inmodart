sealed class Inmueble {}

class Casa extends Inmueble {
  final int habitaciones;
  final double metrosCuadrados;

  Casa(this.habitaciones, this.metrosCuadrados);
}

class Apartamento extends Inmueble {
  final int piso;
  final bool tieneAscensor;

  Apartamento(this.piso, this.tieneAscensor);
}

typedef InfoFinanciera = (double, double, {String zona, double precio});

void procesarCatalogo(List<(Inmueble, InfoFinanciera)> catalogo) {
  for (final (inmueble, info) in catalogo) {
    // ✅ destructuring correcto para Flutter
    final (lat, lng, :zona, :precio) = info;

    String categoria;
    double precioFinal = precio;

    switch (inmueble) {
      case Casa(habitaciones: var h, metrosCuadrados: var m):
        categoria = 'Casa';
        if (m > 200) {
          precioFinal += 10000;
        }

      case Apartamento(piso: var p, tieneAscensor: var ascensor):
        categoria = 'Apartamento';

        if (p >= 1 && p <= 3) {
          precioFinal -= 3000;
        }

        // Reto
        if (p > 5 && !ascensor) {
          precioFinal -= 2000;
        }
    }

    print('--------------------');
    print('Categoría: $categoria');
    print('Zona: $zona');
    print('Ubicación: [$lat, $lng]');
    print('Precio final: \$${precioFinal.toStringAsFixed(2)}');
  }
}

void main() {
  final listaPropiedades = <(Inmueble, InfoFinanciera)>[
    (Casa(5, 250.0), (-12.04, -77.03, zona: 'Miraflores', precio: 180000.0)),
    (
      Apartamento(12, true),
      (-12.08, -76.99, zona: 'San Isidro', precio: 120000.0),
    ),
    (
      Apartamento(6, false),
      (-12.12, -77.01, zona: 'Los Olivos', precio: 45000.0),
    ),
  ];

  procesarCatalogo(listaPropiedades);
}
