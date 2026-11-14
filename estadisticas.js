const API = 'datosEstadisticas.php';

// Helper para llamar al endpoint
async function obtenerDatos(params) {
  const url = API + '?' + new URLSearchParams(params);
  const respuesta = await fetch(url);
  if (!respuesta.ok) throw new Error('HTTP ' + respuesta.status);
  return respuesta.json();
}

// 1. Ventas por mes (columnas), filtrado por marca
async function dibujarVentasPorMes(marca) {
  const datos = await obtenerDatos({ tipo: 'ventas_mes', marca });

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
  const datos = await obtenerDatos({ tipo: 'precio_marca' });

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
  const datos = await obtenerDatos({ tipo: 'disponibilidad' });

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
        y: Number(d.total)
      }))
    }]
  });
}


// Indicadores principales
async function cargarResumen() {
  const datos = await obtenerDatos({ tipo: 'resumen' });

  document.getElementById('total-coches').textContent = datos.total;
  document.getElementById('total-disponibles').textContent = datos.disponibles;
  document.getElementById('total-vendidos').textContent = datos.vendidos;
}

// Selector de marca
async function cargarSelectorMarcas() {
  const marcas = await obtenerDatos({ tipo: 'marcas' });
  const selector = document.getElementById('selector-marca');

  for (const { marca } of marcas) {
    selector.add(new Option(marca, marca));
  }

  selector.addEventListener('change', () => dibujarVentasPorMes(selector.value));

  if (marcas.length) {
    selector.value = marcas[0].marca;
    dibujarVentasPorMes(marcas[0].marca);
  }
}

// Arranque
document.addEventListener('DOMContentLoaded', () => {
  cargarSelectorMarcas().catch(e => console.error('Selector:', e));
  dibujarPrecioPorMarca().catch(e => console.error('Precio:', e));
  dibujarDisponibilidad().catch(e => console.error('Disponibilidad:', e));
  cargarResumen().catch(e => console.error('Resumen:', e));
});

