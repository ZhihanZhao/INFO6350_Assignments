//
//  Book.swift
//  ELibrary
//
//  Created by 赵芷涵 on 12/13/21.
//

import Foundation
import RealmSwift


class Book : Object{
    @objc dynamic var title: String = ""
    @objc dynamic var picAddress: String = ""
    @objc dynamic var subjects: String = ""
    @objc dynamic var InnerKey: String = ""
    @objc dynamic var author: String = ""
    @objc dynamic var publisher: String = ""
    @objc dynamic var version: String = ""
    @objc dynamic var summury: String = ""
    @objc dynamic var published_date: String = ""
    @objc dynamic var language: String = ""
    
    
    override static func primaryKey() -> String? {
        return "InnerKey"
    }
}
