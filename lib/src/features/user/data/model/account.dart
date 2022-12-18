class Account {
  String? addressAR;
  String? addressEN;
  Object? crNumber;
  String? logo;
  Object? nameAR;
  String? nameEN;
  String? uuid;
  String? vatNumber;

  Account({
    this.addressAR,
    this.addressEN,
    this.crNumber,
    this.logo,
    this.nameAR,
    this.nameEN,
    this.uuid,
    this.vatNumber,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      addressAR: json['address_ar'],
      addressEN: json['address_en'],
      crNumber: json['cr_number'],
      logo: json['logo'],
      nameAR: json['name_ar'],
      nameEN: json['name_en'],
      uuid: json['uuid'],
      vatNumber: json['vat_number'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address_ar'] = addressAR;
    data['address_en'] = addressEN;
    data['logo'] = logo;
    data['name_en'] = nameEN;
    data['uuid'] = uuid;
    data['vat_number'] = vatNumber;
    if (crNumber != null) {
      data['cr_number'] = crNumber;
    }
    if (nameAR != null) {
      data['name_ar'] = nameEN;
    }
    return data;
  }
}
