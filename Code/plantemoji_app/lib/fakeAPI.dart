//Will come from the API later
import 'models/plant_species.dart';

class FakeAPI {
  static List<PlantSpecies> speciesList = <PlantSpecies>[
    PlantSpecies(id: 0, name: 'Select', imageLink: 'images/unknownPlant.png'),
    PlantSpecies(
        id: 1, name: 'Rubber plant', imageLink: 'images/rubberPlant.jpg')
  ];
}
