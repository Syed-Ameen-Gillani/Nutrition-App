class Recipes {
  int? id;
  String? name;
  List<String>? ingredients;
  List<String>? instructions;
  int? prepTimeMinutes;
  int? cookTimeMinutes;
  int? servings;
  String? difficulty;
  String? cuisine;
  int? caloriesPerServing;
  List<String>? tags;
  int? userId;
  String? image;

  dynamic rating;
  int? reviewCount;
  List<String>? mealType;

  Recipes({
    this.id,
    this.name,
    this.ingredients,
    this.instructions,
    this.prepTimeMinutes,
    this.cookTimeMinutes,
    this.servings,
    this.difficulty,
    this.cuisine,
    this.caloriesPerServing,
    this.tags,
    this.userId,
    this.image,
    this.rating,
    this.reviewCount,
    this.mealType,
  });

  Recipes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    ingredients = json['ingredients'].cast<String>();
    instructions = json['instructions'].cast<String>();
    prepTimeMinutes = json['prepTimeMinutes'];
    cookTimeMinutes = json['cookTimeMinutes'];
    servings = json['servings'];
    difficulty = json['difficulty'];
    cuisine = json['cuisine'];
    caloriesPerServing = json['caloriesPerServing'];
    tags = json['tags'].cast<String>();
    userId = json['userId'];
    image = json['image'];
    rating = json['rating'];
    reviewCount = json['reviewCount'];
    mealType = json['mealType'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['ingredients'] = ingredients;
    data['instructions'] = instructions;
    data['prepTimeMinutes'] = prepTimeMinutes;
    data['cookTimeMinutes'] = cookTimeMinutes;
    data['servings'] = servings;
    data['difficulty'] = difficulty;
    data['cuisine'] = cuisine;
    data['caloriesPerServing'] = caloriesPerServing;
    data['tags'] = tags;
    data['userId'] = userId;
    data['image'] = image;
    data['rating'] = rating;
    data['reviewCount'] = reviewCount;
    data['mealType'] = mealType;
    return data;
  }
}
