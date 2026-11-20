const API = 'api/estadisticas.php';
// Paleta Okabe-Ito: distinguible con los tipos de daltonismo más comunes
Highcharts.setOptions({
  colors: ['#0072B2', '#E69F00', '#009E73', '#CC79A7',
           '#56B4E9', '#D55E00', '#F0E442', '#000000']
});

// Para llamar al endpoint
async function obtenerDatos(tipo, marca) {
  let url = API + '?tipo=' + encodeURIComponent(tipo);
  if (marca !== undefined) {
    url += '&marca=' + encodeURIComponent(marca);
  }
  const respuesta = await fetch(url);
  if (!respuesta.ok) throw new Error('HTTP ' + respuesta.status);
  return respuesta.json();
}


// 1. Ventas por mes (columnas), filtrado por marca
async function dibujarVentasPorMes(marca) {
  const datos = await obtenerDatos('ventas_mes', marca);

  Highcharts.chart('ventas-por-mes', {
    chart: { type: 'column' },
    title: { text: 'Ventas de ' + marca + ' por mes' },
    xAxis: { categories: datos.map(d => d.mes), title: { text: 'Mes' } },
    yAxis: { title: { text: 'Coches vendidos' }, allowDecimals: false, min: 0 },
    legend: { enabled: false },
    series: [{ name: 'Vendidos', data: datos.map(d => Number(d.total)) }]
  });
}

// 2. Precio medio por marca (barras horizontales)
async function dibujarPrecioPorMarca() {
  const datos = await obtenerDatos('precio_marca')

  Highcharts.chart('precio-por-marca', {
    chart: { type: 'bar' },
    title: { text: 'Precio medio anunciado por marca' },
    xAxis: { categories: datos.map(d => d.marca) },
    yAxis: { title: { text: 'Euros' }, min: 0 },
    legend: { enabled: false },
    series: [{
      name: 'Precio medio',
      data: datos.map(d => Number(d.precio_medio)),
      tooltip: { valueSuffix: ' €' }
    }]
  });
}

// 3. Disponibilidad (donut)
async function dibujarDisponibilidad() {
  const datos = await obtenerDatos('disponibilidad');
  Highcharts.chart('disponibilidad', {
    chart: { type: 'pie' },
    title: { text: 'Disponibilidad del catálogo' },
    plotOptions: {
      pie: { innerSize: '50%', dataLabels: { format: '{point.name}: {point.y}' } }
    },
    series: [{
      name: 'Coches',
      data: datos.map(d => ({
        name: d.estado === 'disponible' ? 'Disponibles' : 'Vendidos',
        y: Number(d.total),
        color: d.estado === 'disponible' ? '#0072B2' : '#E69F00'
      }))
    }]
  });
}


// 4. Coches disponibles por año de matriculación (columnas)
async function dibujarDisponiblesPorAno() {
  const datos = await obtenerDatos('disponibles_ano');

  Highcharts.chart('disponibles-ano', {
    chart: { type: 'column' },
    title: { text: 'Coches disponibles por año' },
    xAxis: { categories: datos.map(d => String(d.ano)), title: { text: 'Año de matriculación' } },
    yAxis: { title: { text: 'Coches' }, allowDecimals: false, min: 0 },
    legend: { enabled: false },
    plotOptions: { column: { dataLabels: { enabled: true } } },
    series: [{ name: 'Disponibles', data: datos.map(d => Number(d.total)) }]
  });
}



// 5. Coches disponibles por rango de precio (columnas)
async function dibujarRangosPrecio() {
  const datos = await obtenerDatos('precios_disponibles');
  const rangos = ['< 10.000 €', '10.000–15.000 €', '15.000–20.000 €', '20.000–25.000 €', '> 25.000 €'];
  const cuenta = [0, 0, 0, 0, 0];

  for (const fila of datos) {
    const precio = Number(fila.precio_anunciado);
    if (precio < 10000) cuenta[0]++;
    else if (precio < 15000) cuenta[1]++;
    else if (precio < 20000) cuenta[2]++;
    else if (precio < 25000) cuenta[3]++;
    else cuenta[4]++;
  }

  Highcharts.chart('rangos-precio', {
    chart: { type: 'column' },
    title: { text: 'Coches disponibles por presupuesto' },
    xAxis: { categories: rangos, title: { text: 'Precio' } },
    yAxis: { title: { text: 'Coches' }, allowDecimals: false, min: 0 },
    legend: { enabled: false },
    plotOptions: { column: { dataLabels: { enabled: true } } },
    series: [{ name: 'Disponibles', data: cuenta }]
  });
}



// Indicadores principales
async function cargarResumen() {
  const datos = await obtenerDatos('resumen');

  document.getElementById('total-coches').textContent = datos.total;
  document.getElementById('total-disponibles').textContent = datos.disponibles;
  document.getElementById('total-vendidos').textContent = datos.vendidos;
}

// Selector de marca
async function cargarSelectorMarcas() {
  const marcas = await obtenerDatos('marcas');
  const selector = document.getElementById('selector-marca');

  for (const fila of marcas) {
    const opcion = document.createElement('option');
    opcion.setAttribute('value', fila.marca);
    opcion.textContent = fila.marca;
    selector.appendChild(opcion);
  }


  selector.addEventListener('change', () => dibujarVentasPorMes(selector.value));

  if (marcas.length) {
    selector.value = marcas[0].marca;
    dibujarVentasPorMes(marcas[0].marca);
  }
}

// Arranque
document.addEventListener('DOMContentLoaded', () => {
  cargarSelectorMarcas().catch(e => console.error('Selector:', e.message));
  dibujarPrecioPorMarca().catch(e => console.error('Precio:', e.message));
  dibujarDisponibilidad().catch(e => console.error('Disponibilidad:', e.message));
  dibujarDisponiblesPorAno().catch(e => console.error('Por año:', e.message));
  dibujarRangosPrecio().catch(e => console.error('Rangos:', e.message));
  cargarResumen().catch(e => console.error('Resumen:', e.message));
});

