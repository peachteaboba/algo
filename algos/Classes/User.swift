//
//  User.swift
//  algos
//
//  Created by Andy Feng on 2/27/17.
//  Copyright © 2017 Andy Feng. All rights reserved.
//

import Foundation

class User {
    
    var email: String
    var username: String
    var password: String
    
    init(email: String, username: String, password: String){
        self.username = username
        self.email = email
        self.password = password
    }
 
}
