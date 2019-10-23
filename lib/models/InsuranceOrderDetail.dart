class InsuranceOrderDetail {
  String orderId;
  String title;
  int status;
  String period;
  String guardPerson;
  String insurancePrice;
  String orderGenerateDate;

  InsuranceOrderDetail(
      {this.orderId,
      this.title,
      this.status,
      this.period,
      this.guardPerson,
      this.insurancePrice,
      this.orderGenerateDate});

  InsuranceOrderDetail.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    title = json['title'];
    status = json['status'];
    period = json['period'];
    guardPerson = json['guardPerson'];
    insurancePrice = json['insurancePrice'];
    orderGenerateDate = json['orderGenerateDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['title'] = this.title;
    data['status'] = this.status;
    data['period'] = this.period;
    data['guardPerson'] = this.guardPerson;
    data['insurancePrice'] = this.insurancePrice;
    data['orderGenerateDate'] = this.orderGenerateDate;
    return data;
  }
}
