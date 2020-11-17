

class TPDetailSaleModel {
  int sellId;
  int createTime;
  String rate;
  String currentCount;
  PayMethodVO payMethodVO;
  int payId;
  String max;
  String sellNo;
  String totalCount;
  String walletAddress;
  String realCount;
  int status;
  String charge;
  String recCount;
  String maxAmount;

  TPDetailSaleModel(
      {this.sellId,
      this.createTime,
      this.rate,
      this.currentCount,
      this.payMethodVO,
      this.payId,
      this.sellNo,
      this.totalCount,
      this.walletAddress,
      this.realCount,
      this.status,
      this.max,
      this.charge,
      this.recCount,
      this.maxAmount});

  TPDetailSaleModel.fromJson(Map<String, dynamic> json) {
    sellId = json['sellId'];
    createTime = json['createTime'];
    rate = json['rate'];
    max = json['max'];
    currentCount = json['currentCount'];
    payMethodVO = json['payMethodVO'] != null
        ? new PayMethodVO.fromJson(json['payMethodVO'])
        : null;
    payId = json['payId'];
    sellNo = json['sellNo'];
    totalCount = json['totalCount'];
    walletAddress = json['walletAddress'];
    realCount = json['realCount'];
    status = json['status'];
    charge = json['charge'];
    recCount = json['recCount'];
    maxAmount = json['maxAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sellId'] = this.sellId;
    data['createTime'] = this.createTime;
    data['rate'] = this.rate;
    data['currentCount'] = this.currentCount;
    if (this.payMethodVO != null) {
      data['payMethodVO'] = this.payMethodVO.toJson();
    }
    data['payId'] = this.payId;
    data['sellNo'] = this.sellNo;
    data['totalCount'] = this.totalCount;
    data['walletAddress'] = this.walletAddress;
    data['realCount'] = this.realCount;
    data['status'] = this.status;
    data['max'] = this.max;
    data['charge'] = this.charge;
    data['recCount'] = this.recCount;
    data['maxAmount'] = this.maxAmount;
    return data;
  }
}

class PayMethodVO {
  String realName;
  int createTime;
  String payMethodName;
  String quota;
  int payId;
  String subBranch;
  int type;
  String walletAddress;
  String account;

  PayMethodVO(
      {this.realName,
      this.createTime,
      this.payMethodName,
      this.quota,
      this.payId,
      this.subBranch,
      this.type,
      this.walletAddress,
      this.account});

  PayMethodVO.fromJson(Map<String, dynamic> json) {
    realName = json['realName'];
    createTime = json['createTime'];
    payMethodName = json['payMethodName'];
    quota = json['quota'];
    payId = json['payId'];
    subBranch = json['subBranch'];
    type = json['type'];
    walletAddress = json['walletAddress'];
    account = json['account'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['realName'] = this.realName;
    data['createTime'] = this.createTime;
    data['payMethodName'] = this.payMethodName;
    data['quota'] = this.quota;
    data['payId'] = this.payId;
    data['subBranch'] = this.subBranch;
    data['type'] = this.type;
    data['walletAddress'] = this.walletAddress;
    data['account'] = this.account;
    return data;
  }
}