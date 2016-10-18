//
//  ViewControllerSWIFT.swift
//  Classes
//
//  Created by Kevin Harris on 10/17/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

// To use Objetive-C classes in Swift files, you need to add an #import to 
// the bridging header file created by the project called: "Classes-Bridging-Header.h"

class ViewControllerSWIFT: UIViewController {

    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        test()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func test() {
        
        //
        // Test Objective-C class...
        //
        
        let personObjc1 = PersonOBJC()
        
        print("name = \(personObjc1?.name)")
        print("age = \(personObjc1?.age)")
        
        
        let personObjc2 = PersonOBJC(name: "Steve Jobs", andAge: 56)
        
        print("name = \(personObjc2?.name)")
        print("age = \(personObjc2?.age)")
        
        //
        // Test Swift class...
        //
        
        let personSwift1 = PersonSWIFT()
        
        print("name = \(personSwift1.name)")
        print("age = \(personSwift1.age)")
        
        
        let personSwift2 = PersonSWIFT(name: "Tim Cook", age: 55)
        
        print("name = \(personSwift2.name)")
        print("age = \(personSwift2.age)")
    }
}

