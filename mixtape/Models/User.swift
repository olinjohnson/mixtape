//
//  User.swift
//  mixtape
//
//  Created by Olin Johnson on 6/24/24.
//

import Foundation
import JWTDecode

struct User {
    
    let id: String
    let name: String
    let email: String
    let emailVerified: Bool
    let picture: String
    
}

extension User {
    static func from(_ idToken: String) -> Self {
        
        guard
            let jwt = try? decode(jwt: idToken),
            let id = jwt.subject,
            let name = jwt.claim(name: "name").string,
            let email = jwt.claim(name: "email").string,
            let emailVerified = jwt.claim(name: "email_verified").boolean,
            let picture = jwt.claim(name: "picture").string
        else {
            return User(id: "", name: "", email: "", emailVerified: false, picture: "")
        }
        
        return User(id: id, name: name, email: email, emailVerified: emailVerified, picture: picture)
        
    }
}
