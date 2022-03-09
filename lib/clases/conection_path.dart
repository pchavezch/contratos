var baseApiRestSite = "http://192.168.1.105";
//var baseApiRestSite = "http://contratos.trustfiduciaria.com";
var baseApiRestPort = "7000";
var baseURLDocuments = "http://contratos.trustfiduciaria.com";

class ConnectionPath {
  var restApiLogin =
      baseApiRestSite + ":" + baseApiRestPort + "/api/Auth/Login";
  var restApiGetContractsAdh = baseApiRestSite +
      ":" +
      baseApiRestPort +
      "/api/ContratosAdh/GetContracts";
  var restApiGetContractsTerm = baseApiRestSite +
      ":" +
      baseApiRestPort +
      "/api/ContratosAdh/GetContracts";
  var restApiGetValues =
      baseApiRestSite + ":" + baseApiRestPort + "/api/Options/GetValue";
}
