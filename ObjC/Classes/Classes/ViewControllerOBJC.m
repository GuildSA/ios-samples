//
//  ViewControllerOBJC.m
//  Classes
//
//  Created by Kevin Harris on 10/17/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

#import "ViewControllerOBJC.h"
#import "PersonOBJC.h"

// To use Swift classes in Objetive-C files, you need to import a file called: "<project-name>-Swift.h".
#import "Classes-Swift.h"

@interface ViewControllerOBJC ()

@end

@implementation ViewControllerOBJC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self test];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)test {
    
    //
    // Test Objective-C class...
    //
    
    PersonOBJC * personObjc1 = [[PersonOBJC alloc] init];
    
    NSLog(@"name = %@", personObjc1.name);
    NSLog(@"age = %d", personObjc1.age);
    
    PersonOBJC * personObjc2 = [[PersonOBJC alloc] initWithName: @"Steve Jobs" andAge: 56];
    
    NSLog(@"name = %@", personObjc2.name);
    NSLog(@"age = %d", personObjc2.age);
    
    //
    // Test Swift class...
    //
    
    PersonSWIFT * personSwift1 = [[PersonSWIFT alloc] init];
    
    NSLog(@"name = %@", personSwift1.name);
    NSLog(@"age = %ld", (long)personSwift1.age);
    
    PersonSWIFT * personSwift2 = [[PersonSWIFT alloc] initWithName:@"Tim Cook" age:55];
    
    NSLog(@"name = %@", personSwift2.name);
    NSLog(@"age = %ld", (long)personSwift2.age);
}


@end
