//
//  Items.swift
//  ToDo
//
//  Created by Catherine Chan on 17/10/18.
//  Copyright © 2018 Infinite Potential App Ltd. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
   @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items") // each category has one to Many relationship with List of Item and each item has a inversed relationship to a parentCategory
    
}
