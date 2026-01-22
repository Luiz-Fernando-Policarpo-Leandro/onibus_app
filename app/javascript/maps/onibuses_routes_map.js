document.addEventListener("turbo:load", initializeMap);
document.addEventListener("DOMContentLoaded", initializeMap);

function initializeMap() {
  const mapElement = document.getElementById("map");
  if (!mapElement) return;

  const rotaId = mapElement.dataset.rotaId;
  
  // Se não há rotaId, tenta obter da URL
  const urlRotaId = window.location.pathname.match(/\/rota\/(\d+)/)?.[1];
  const finalRotaId = rotaId || urlRotaId;
  
  if (!finalRotaId) {
    console.error("rotaId não encontrado");
    return;
  }

  if (typeof L === "undefined") {
    console.error("Leaflet não carregou");
    return;
  }

  // Inicializar mapa
  const map = L.map("map").setView([-9.6658, -35.7353], 11);

  L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
    attribution: "© OpenStreetMap contributors",
    maxZoom: 19
  }).addTo(map);

  // Buscar trajetória
  fetch(`/rota/${finalRotaId}/trajetoria`)
    .then(res => {
      if (!res.ok) throw new Error(`Erro HTTP: ${res.status}`);
      return res.json();
    })
    .then(geojson => {
      if (!geojson) {
        console.warn("Trajetória vazia");
        return;
      }
      
      const rotaLayer = L.geoJSON(geojson, {
        style: {
          color: '#3388ff',
          weight: 4,
          opacity: 0.8
        }
      }).addTo(map);
      
      map.fitBounds(rotaLayer.getBounds(), { padding: [50, 50] });
    })
    .catch(err => console.error("Erro:", err));
}