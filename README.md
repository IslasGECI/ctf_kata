# KATA: Predicción de la edad de pollos de petrel negro a partir de su morfometría

Debes estimar la edad (en días) de un conjunto de pollos de petrel negro a partir de su morfometría.
Someterás tu respuesta en una tabla de dos columnas: la primer columna es el identificador del pollo
y la segunda columna es la edad estimada.

## Instrucciones

En el Makefile de este repo, agrega al _phony_ **submissions** el nombre de tu tabla CSV con el
formato `pollos_petrel/<TU_NOMBRE>_submission.csv`. Reemplaza `<TU_NOMBRE>` con tu nombre.

El _phony_ submissions debería verse así:

```
submissions: \
    pollos_petrel/evaro_submission.csv \
    pollos_petrel/example_submission.csv \
    pollos_petrel/<TU_NOMBRE>_submission.csv
```

(Nota las diagonales invertidas `\` al final de cada línea, excepto en la última)

Agrega al Makefile como objetivo la tabla CSV `pollos_petrel/<TU_NOMBRE>_submission.csv`. Esta tabla
debe tener dos columnas: **id** y **target**. Ve el ejemplo: `pollos_petrel/example_submission.csv`.

Ejemplo:

 id           | target
--------------|--------
H9-2013-09-16 | 0.83
B5-2015-09-02 | 0.94
A9-2017-09-09 | 0.50

## Descripción de las tablas
En el directorio `pollos_petrel/` puedes encontrar cuatro archivos CSV.

- Usa el archivo `train.csv` para entrenar tu algoritmo.
- Usa el archivo `test.csv` para evaluar tu algoritmo.
- Usa los archivos `*_submission.csv` como ejemplos de solución.

## Descripción de los campos de las tablas
- La primer columna se llama **id** y contiene un identificador único para cada registro.
- La última columna se llama **target** y contiene la edad (en días) de los pollos. Esta columna
  representa la _respuesta_.
- El resto de las columnas (**Peso**, **Longitud_tarso**, ...,
  **Longitud_pluma_exterior_de_la_cola**) son las varibles _predictivas_.
