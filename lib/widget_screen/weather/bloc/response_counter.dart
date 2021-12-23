class ResponseCounter {
  ResponseCounter([this.apiLimit = 1, this.memoryLimit = 5]);

  late int apiLimit;
  late int memoryLimit;
  int apiRequest = 0;
  int romRequest = 0;

  get openFromAPI => apiRequest < apiLimit;
  get openFromROM => romRequest < memoryLimit;

  incrementAPI() {
    apiRequest++;
  }

  incrementROM(){
    romRequest++;
  }

  resetAPIRequest() {
    apiRequest = 0;
  }

  resetROMRequest() {
    romRequest = 0;
  }

  reset() {
    resetAPIRequest();
    resetROMRequest();
  }
}