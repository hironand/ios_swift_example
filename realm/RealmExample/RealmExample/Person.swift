//
//  Person.swift
//  RealmExample
//
//  Created by hironand on 2016/12/31.
//  Copyright © 2016年 hironand. All rights reserved.
//

import RealmSwift

class Person: Object {
    dynamic var name: String? = nil
    let age =  RealmOptional<Int>()
}
