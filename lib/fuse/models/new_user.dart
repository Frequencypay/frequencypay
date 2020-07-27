class NewUser {
    List<UsersAdded> usersAdded;

    NewUser({this.usersAdded});

    factory NewUser.fromJson(Map<String, dynamic> json) {
        return NewUser(
            usersAdded: json['UsersAdded'] != null ? (json['UsersAdded'] as List).map((i) => UsersAdded.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.usersAdded != null) {
            data['usersAdded'] = this.usersAdded.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class UsersAdded {
    String created;
    String id;
    bool isDormant;
    bool isTest;
    String updated;
    String virtualCardEnrollmentStatus;
    String zipCode;

    UsersAdded({this.created, this.id, this.isDormant, this.isTest, this.updated, this.virtualCardEnrollmentStatus, this.zipCode});

    factory UsersAdded.fromJson(Map<String, dynamic> json) {
        return UsersAdded(
            created: json['Created'],
            id: json['Id'],
            isDormant: json['IsDormant'],
            isTest: json['IsTest'],
            updated: json['Updated'],
            virtualCardEnrollmentStatus: json['VirtualCardEnrollmentStatus'],
            zipCode: json['ZipCode'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['created'] = this.created;
        data['id'] = this.id;
        data['isDormant'] = this.isDormant;
        data['isTest'] = this.isTest;
        data['updated'] = this.updated;
        data['virtualCardEnrollmentStatus'] = this.virtualCardEnrollmentStatus;
        data['zipCode'] = this.zipCode;
        return data;
    }
}