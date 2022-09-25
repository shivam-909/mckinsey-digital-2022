class PinLocation {
  final List<double> coords;
  final LocationType type;

  // static Map<List<double>, LocationType> locs = {
  //   [51.52508720339613, -0.13688997453422003]: LocationType.Store,
  //   [51.523094618447885, -0.14107422059745245]: LocationType.Store,
  //   [51.52409092182112, -0.13898209756583624]: LocationType.Store,

  // }

  static List<List<double>> stores = [
    [51.52508720339613, -0.13688997453422003],
    [51.523094618447885, -0.14107422059745245],
    [51.52409092182112, -0.13898209756583624],
  ];

  static List<List<double>> foodbanks = [
    [51.52661010733251, -0.10202039135743135],
    [51.51066751941836, -0.13549435986329073],
    [51.518639510948724, -0.11875737561036104],
  ];

  PinLocation(this.coords, this.type);

  static List<PinLocation> allLocs = [
    PinLocation([51.52508720339613, -0.13688997453422003], LocationType.Store),
    PinLocation([
      51.523094618447885,
      -0.14107422059745245,
    ], LocationType.Store),
    PinLocation([51.52409092182112, -0.13898209756583624], LocationType.Store),
    PinLocation(
        [51.52661010733251, -0.10202039135743135], LocationType.FoodBank),
    PinLocation(
        [51.51066751941836, -0.13549435986329073], LocationType.FoodBank),
    PinLocation(
        [51.518639510948724, -0.11875737561036104], LocationType.FoodBank),
  ];
}

enum LocationType { Store, FoodBank }
