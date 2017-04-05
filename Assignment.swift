//
//  Assignment.swift
//  Assignment Helper
//
//  Created by Oliver on 2/23/17.
//  Copyright © 2017 Oliver. All rights reserved.
//

import Foundation

//class defines what is in an assignment with its parameters
class Assignment: NSCoder{

    let name: String
    let priority: String
    let duedate: String
    
    init(name: String, priority: String, duedate: String){
        self.name = name
        self.priority = priority
        self.duedate = duedate
    }
    

    
    

}

    
