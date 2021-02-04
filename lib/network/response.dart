class Response<T> {
  ResponseStatus status;
  T data;
  String message;

  Response.loading(this.message) : status = ResponseStatus.LOADING;

  Response.completed(this.data) : status = ResponseStatus.COMPLETED;

  Response.error(this.message) : status = ResponseStatus.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum ResponseStatus { LOADING, COMPLETED, ERROR }
