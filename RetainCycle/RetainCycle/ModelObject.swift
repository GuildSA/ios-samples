//
//  ModelObject.swift
//  RetainCycle
//
//  Created by Kevin Harris on 7/5/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import Foundation

protocol ModelObjectDelegate: class {
    
}

class ModelObject {
    
    // A strong var will cause a retain cycle that will create a memory leak.
    var delegate: ModelObjectDelegate?
    
    // A weak var will break the retain cycle and prevent a memory leak.
    //weak var delegate: ModelObjectDelegate?
    
    init() {
        print("ModelObject init!")
    }
    
    deinit {
        print("ModelObject deinit!")
    }
}
