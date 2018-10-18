//
//  Category.swift
//  ToDo
//
//  Created by Catherine Chan on 17/10/18.
//  Copyright © 2018 Infinite Potential App Ltd. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object { // Object is a Realm dataType
    @objc dynamic var name : String = "" // with daynamic key word, we can monitor the change of the variable during runtime
    let items = List<Item>() // the variable items is going to point to a List of Item object. 
    
    //a few ways to declare array
    //let array = [1,2,3]
    //let array = [Int] () // array of integer, we initialise it as empty array
    // let array : [Int] = [1,2,3]
    // let array : Array<Int> = [1,2,3]
    // let array : Array<Int>() => empty array of Int
    
}
