

async function insertarComponente(archivo, selector) {
  const destino = document.querySelector(selector);
  try {
    const respuesta = await fetch('componentes/' + archivo + '.html');
    if (!respuesta.ok) {
      throw new Error('Error HTTP ' + respuesta.status);
    }
    destino.innerHTML = await respuesta.text();
    return true;
  } catch (error) {
    destino.textContent = 'No se ha podido cargar ' + archivo + '.';
    return false;
  }
}

async function cargarCabecera() {
  // El espacio para el menú está dentro de la cabecera.
  const cabeceraCargada = await insertarComponente('header', '#cabecera');
  if (!cabeceraCargada) return;

  const menuCargado = await insertarComponente('navbar', '#menu');
  if (!menuCargado) return;

  const pagina = document.body.getAttribute('id') + '.html';
  const enlace = document.querySelector('#menu a[href="' + pagina + '"]');
  if (enlace) {
    enlace.setAttribute('class', 'actual');
    enlace.setAttribute('aria-label', enlace.textContent + ', página actual');
  }
}

cargarCabecera();
insertarComponente('footer', '#pie');
