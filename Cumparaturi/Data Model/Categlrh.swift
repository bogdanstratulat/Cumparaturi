//
//  Categlrh.swift
//  Cumparaturi
//
//  Created by Bogdan Stratulat on 07/01/2019.
//  Copyright © 2019 Bogdan Stratulat. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name: String = ""
    let items = List<Item>()

}
