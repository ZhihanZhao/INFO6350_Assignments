//
//  User.swift
//  ELibrary
//
//  Created by 赵芷涵 on 12/14/21.
//

import Foundation
import RealmSwift


class User : Object{
    @objc dynamic var userID: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var summary: String = ""
    @objc dynamic var age: String = ""
    
    override static func primaryKey() -> String? {
        return "userID"
    }
}
