document.addEventListener("turbo:load", () => {
  const professionalMistakeDetector = document.getElementById("map");
  if (!professionalMistakeDetector) return;

  const map = L.map("map").setView([-9.6658, -35.7353], 8);

  L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
    attribution: "&copy; OpenStreetMap contributors"
  }).addTo(map);

  L.marker([-9.6498, -35.7089])
    .addTo(map)
    .bindPopup("Parada Central");
});
