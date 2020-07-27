class UserProfile {
    List<ProfileAdded> profilesAdded;

    UserProfile({this.profilesAdded});

    factory UserProfile.fromJson(Map<String, dynamic> json) {
        return UserProfile(
            profilesAdded: json['ProfilesAdded'] != null ? (json['ProfilesAdded'] as List).map((i) => ProfileAdded.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.profilesAdded != null) {
            data['ProfilesAdded'] = this.profilesAdded.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class ProfileAdded {
    String address1;
    String address2;
    String city;
    String created;
    String email;
    String id;
    bool isPrimary;
    String name;
    String profileType;
    String state;
    String updated;
    String zipCode;

    ProfileAdded({this.address1, this.address2, this.city, this.created, this.email, this.id, this.isPrimary, this.name, this.profileType, this.state, this.updated, this.zipCode});

    factory ProfileAdded.fromJson(Map<String, dynamic> json) {
        return ProfileAdded(
            address1: json['Address1'],
            address2: json['Address2'],
            city: json['City'],
            created: json['Created'],
            email: json['Email'],
            id: json['Id'],
            isPrimary: json['IsPrimary'],
            name: json['Name'],
            profileType: json['ProfileType'],
            state: json['State'],
            updated: json['Updated'],
            zipCode: json['ZipCode'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['Address1'] = this.address1;
        data['Address2'] = this.address2;
        data['City'] = this.city;
        data['Created'] = this.created;
        data['Email'] = this.email;
        data['Id'] = this.id;
        data['IsPrimary'] = this.isPrimary;
        data['Name'] = this.name;
        data['ProfileType'] = this.profileType;
        data['State'] = this.state;
        data['Updated'] = this.updated;
        data['ZipCode'] = this.zipCode;
        return data;
    }
}