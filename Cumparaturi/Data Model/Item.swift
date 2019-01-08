//
//  Item.swift
//  Cumparaturi
//
//  Created by Bogdan Stratulat on 07/01/2019.
//  Copyright © 2019 Bogdan Stratulat. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreate: Date?
    var parentCateogy = LinkingObjects(fromType: Category.self, property: "items")
   
    
}
