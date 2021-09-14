const GOOGLE_API_KEY = "AIzaSyAJln1eh_8ocXupg17n0q0AKdTZisVR03Q";

class LocationHelper {
  static String generateLocationPerviewImage(lat, longi) {
    return 'https://open.mapquestapi.com/staticmap/v4/getmap?key=QasoNigmCWjD4iN9Z7nasGqomxGYvcEI&size=600,400&type=map&imagetype=png&pois=1,$lat,$longi,-20,-20|2,$lat,$longi|3,$lat,$longi|4,40.0697,-76.352';
  }
}
