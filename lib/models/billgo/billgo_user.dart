class BillGo_User_Model {
    List<UsersAdded> usersAdded;

    BillGo_User_Model({this.usersAdded});

    factory BillGo_User_Model.fromJson(Map<String, dynamic> json) {
        return BillGo_User_Model(
            usersAdded: json['usersAdded'] != null ? (json['usersAdded'] as List).map((i) => UsersAdded.fromJson(i)).toList() : null, 
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
    String partnerProfileId;
    String partnerUserId;
    String updated;
    String zipCode;

    UsersAdded({this.created, this.id, this.isDormant, this.isTest, this.partnerProfileId, this.partnerUserId, this.updated, this.zipCode});

    factory UsersAdded.fromJson(Map<String, dynamic> json) {
        return UsersAdded(
            created: json['created'], 
            id: json['id'], 
            isDormant: json['isDormant'], 
            isTest: json['isTest'], 
            partnerProfileId: json['partnerProfileId'], 
            partnerUserId: json['partnerUserId'], 
            updated: json['updated'], 
            zipCode: json['zipCode'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['created'] = this.created;
        data['id'] = this.id;
        data['isDormant'] = this.isDormant;
        data['isTest'] = this.isTest;
        data['partnerProfileId'] = this.partnerProfileId;
        data['partnerUserId'] = this.partnerUserId;
        data['updated'] = this.updated;
        data['zipCode'] = this.zipCode;
        return data;
    }
}