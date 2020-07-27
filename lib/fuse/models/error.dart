class Error {
    ErrorX error;

    Error({this.error});

    factory Error.fromJson(Map<String, dynamic> json) {
        return Error(
            error: json['error'] != null ? ErrorX.fromJson(json['error']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.error != null) {
            data['error'] = this.error.toJson();
        }
        return data;
    }
}

class ErrorX {
    String code;
    String message;

    ErrorX({this.code, this.message});

    factory ErrorX.fromJson(Map<String, dynamic> json) {
        return ErrorX(
            code: json['code'],
            message: json['message'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        data['message'] = this.message;
        return data;
    }
}