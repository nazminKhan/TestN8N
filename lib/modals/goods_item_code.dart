class GoodsItemCode {
  final String? goodsType;
  final String? goodsDescription;
  final String? goodsRate;
  final String? goodsHsnCode;

  GoodsItemCode({
    this.goodsType,
    this.goodsDescription,
    this.goodsRate,
    this.goodsHsnCode,
  });

  // Factory method to create an instance from JSON
  factory GoodsItemCode.fromJson(Map<String, dynamic> json) {
    return GoodsItemCode(
      goodsType: json['type'],
      goodsDescription: json['description'],
      goodsRate: json['rate'],
      goodsHsnCode: json['hsn'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'type': goodsType,
      'description': goodsDescription,
      'rate': goodsRate,
      'hsn': goodsHsnCode,
    };
  }
}