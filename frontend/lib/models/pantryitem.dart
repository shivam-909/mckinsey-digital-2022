class PantryItem {
  PantryItem({required this.imageUrl, required this.name, required this.useBy});

  final String imageUrl;
  final String name;
  final DateTime useBy;

  static List<PantryItem> placeholderList = [
    PantryItem(
        imageUrl:
            "https://t3.ftcdn.net/jpg/01/91/55/42/360_F_191554261_Kfn9mPkFP2lRmNuSkLkoe6yMnOdC1GUC.jpg",
        name: "Onion",
        useBy: DateTime(
          2022,
          9,
          24,
        )),
    PantryItem(
        imageUrl:
            "https://image.shutterstock.com/image-photo/red-tomatoes-isolated-on-white-260nw-365250149.jpg",
        name: "Tomato",
        useBy: DateTime(
          2022,
          9,
          26,
        )),
    PantryItem(
        imageUrl:
            "https://nutritionadvance.com/wp-content/uploads/2018/01/whole-garlic-with-skin-and-a-garlic-clove.jpg",
        name: "Garlic",
        useBy: DateTime(
          2022,
          10,
          4,
        ))
  ];
}
