class ItemModel {
  String name;
  String Publish_date;
  int prix_originale;
  int prix_apres_promotion;
  List<dynamic> urls;
  String url1;
  String Details;

  ItemModel(
      this.name,
      this.Publish_date,
      this.prix_originale,
      this.prix_apres_promotion,
      this.urls,
      this.url1,
      this.Details,

      );
  ItemModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    Publish_date = json['Publish_date'];
    urls = json['urls'];
    url1 = json['url1'];
    prix_originale = json['prix_originale'];
    prix_apres_promotion = json['prix_apres_promotion'];
    Details = json['Details'];
    }
  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['Publish_date'] = this.Publish_date;
    data['prix_originale'] = this.prix_originale;
    data['urls'] = this.urls;
    data['url1'] = this.url1;
    data['prix_apres_promotion'] = this.prix_apres_promotion;
    data['Details'] = this.Details;
     return data;
  }
}

