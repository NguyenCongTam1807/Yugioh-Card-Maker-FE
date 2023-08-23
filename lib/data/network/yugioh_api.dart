class YugiohApi {
  static const baseUrl = "http://10.0.2.2:8080/api/v1.0";
  static const getAllCards = "$baseUrl/cards";
  static const getAllByCardNameContaining = "$baseUrl/";
  static const getAllByCreatorName = "$baseUrl/?creatorName=";
  static const uploadCard = "$baseUrl/cards";
  static const deleteById = "$baseUrl/";
}