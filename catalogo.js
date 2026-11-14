const selectorMarca = document.querySelector('#marca-catalogo');
const lista = document.querySelector('#lista-coches');
const aviso = document.querySelector('#estado-catalogo');

let ultimaConsulta = 0;

function crearFicha(coche) {
  const elemento = document.createElement('li');
  const ficha = document.createElement('article');
  ficha.setAttribute('class', 'card');
  const titulo = document.createElement('h3');
  titulo.textContent = coche.marca + ' ' + coche.modelo;

  const recorrido = document.createElement('p');
  recorrido.textContent = coche.ano_matriculacion + ' · ' +
    coche.kilometraje_km + ' km';

  const motor = document.createElement('p');
  motor.textContent = coche.combustible + ' · ' + coche.tipo_cambio;

  const precio = document.createElement('p');
  precio.setAttribute('class', 'price');
  precio.textContent = coche.precio_anunciado + ' €';
  if (coche.ruta_foto) {
    const foto = document.createElement('img');
    foto.setAttribute('src', coche.ruta_foto);
    foto.setAttribute('alt', 'Fotografía de referencia del ' + coche.marca + ' ' + coche.modelo);
    ficha.appendChild(foto);
  }
  ficha.appendChild(titulo);
  ficha.appendChild(recorrido);
  ficha.appendChild(motor);
  ficha.appendChild(precio);
  elemento.appendChild(ficha);
  return elemento;
}

async function cargarCoches() {
  ultimaConsulta = ultimaConsulta + 1;
  const consulta = ultimaConsulta;
  lista.replaceChildren();
  aviso.textContent = 'Cargando coches…';
  try {
    const respuesta = await fetch('api/coches.php?marca=' + encodeURIComponent(selectorMarca.value));
    if (!respuesta.ok) throw new Error('Error al consultar el catálogo');
    const coches = await respuesta.json();

    // Si el usuario ha vuelto a cambiar la marca, esperamos la consulta más reciente.
    if (consulta !== ultimaConsulta) return;
    for (const coche of coches) {
      lista.appendChild(crearFicha(coche));
    }
    if (coches.length === 0) {
      aviso.textContent = 'No hay coches disponibles de esta marca.';
    } else {
      aviso.textContent = 'Coches disponibles: ' + coches.length;
    }
  } catch (error) {
    if (consulta === ultimaConsulta) aviso.textContent = 'No se ha podido cargar el catálogo. Comprueba la conexión con XAMPP.';
  }
}

selectorMarca.addEventListener('change', cargarCoches);
cargarCoches();