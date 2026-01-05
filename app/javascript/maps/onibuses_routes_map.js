// app/javascript/maps/onibuses_routes_map.js
document.addEventListener("DOMContentLoaded", () => {
  const mapElement = document.getElementById("map");
  if (!mapElement) return;

  const rotaId = mapElement.dataset.rotaId;
  console.log("rotaId:", rotaId);

  if (!rotaId) {
    console.error("rotaId não encontrado no data-attribute");
    return;
  }

  const map = L.map("map").setView([-9.6658, -35.7353], 11);

  L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
    attribution: "© OpenStreetMap contributors"
  }).addTo(map);

  fetch(`/rota/${rotaId}/trajetoria`)
    .then(res => {
      if (!res.ok) throw new Error("Erro HTTP");
      return res.json();
    })
    .then(geojson => {
      const rotaLayer = L.geoJSON(geojson).addTo(map);
      map.fitBounds(rotaLayer.getBounds());
    })
    .catch(err => {
      console.error("Erro ao buscar trajetória:", err);
    });
});
