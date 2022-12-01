//
//  RegisteredUsers.swift
//  UILabel 12
//
//  Created by Aleksey Kosov on 01.12.2022.
//

import Foundation

struct Users: Equatable {
    
    static var allUsers = [user1,user2,user3]
    
    var email: String
    var password: String
    var age: Int
}

//MARK: - Already Registered

var user1 = Users(email: "123@mail.com", password: "123456", age: 54)
var user2 = Users(email: "obema@icloud.com", password: "123321", age: 34)
var user3 = Users(email: "1488@mail.com", password: "14881488", age: 22)
