class all_listAttributes {


  String title="";

  String price="0";

  String type="";

  String wegiht="";

  String color="";

  String image="";

  String merchant="";

  int quantity=1;

  String size="";

  String url="";

  String dimensions = "";





  all_listAttributes (this.title, this.price, this.type,this.quantity, this.wegiht, this.color, this.image,
      this.merchant,this.size, this.url,{this.dimensions});


  String getTitle(String title)
  {
    title=this.title;
  }

  void setUrl(String url){

    this.url = url;

  }

  String getUrl(){

    return url;

  }

  Map<String, dynamic> toJsonAttr(String id) => {
    "userid":id==null || id.isEmpty?"":int.parse(id),
    "name": title,
    "quantity": quantity,
    "image": image,
    "price": double.parse(price.replaceAll("\$","").substring(0, price.indexOf('.'))),
    "url":url,
    "color":color,
    "weight":wegiht,
    "merchant":merchant,
    "size":size,
    "dimensions":dimensions
  };
  Map<String, dynamic> toJsonAtt() => {
    "name": title,
    "quantity": quantity,
    "price":double.parse(price.replaceAll("\$","")),
  };

}

