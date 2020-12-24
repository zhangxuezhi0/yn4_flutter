class MainItem {
  var id;

  String name;

  String iconUrl;

  double starRating;

  String downloadUrl;

  String description1;

  String description2;

  String description3;

  String detailDescription;

  String loan;

  String amounts;

  String loanPeriods;

  double dailyInterestRate;

  MainItem({
    this.id,
    this.name,
    this.iconUrl,
    this.starRating,
    this.downloadUrl,
    this.description1,
    this.description2,
    this.description3,
    this.detailDescription,
    this.loan,
    this.amounts,
    this.loanPeriods,
    this.dailyInterestRate,
  });

  factory MainItem.fromJson(Map<String, dynamic> json) {
    return MainItem(
      id: json['id'],
      name: json['name'],
      iconUrl: json['iconUrl'],
      starRating: json['starRating'],
      downloadUrl: json['downloadUrl'],
      description1: json['description1'],
      description2: json['description2'],
      description3: json['description3'],
      detailDescription: json['detailDescription'],
      loan: json['loan'],
      amounts: json['amounts'],
      loanPeriods: json['loanPeriods'],
      dailyInterestRate: json['dailyInterestRate'],
    );
  }
}
