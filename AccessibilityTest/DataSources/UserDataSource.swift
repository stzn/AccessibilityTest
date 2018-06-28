//
//  UserDataSource.swift
//  AccessibilityTest
//
//  Created by stakata on 2018/06/25.
//  Copyright © 2018年 shiz. All rights reserved.
//

import Foundation

struct UserDataSource {
    
    static func users() -> [User] {
        let userList = [
            User(id: 1, name: "じろう", imageUrl: "a"),
            User(id: 2, name: "かおり", imageUrl: "b"),
            User(id: 3, name: "おじいちゃん", imageUrl: "c"),
            User(id: 4, name: "おとうさん", imageUrl: "d"),
            User(id: 5, name: "おかあさん", imageUrl: "e"),
        ]
        return userList
    }
}
