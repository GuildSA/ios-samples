//
//  PersonOBJC.m
//  Singleton
//
//  Created by Kevin Harris on 10/17/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonOBJC.h"

@implementation PersonOBJC

- (id)init {
    
    NSLog(@"New PersonOBJC Initialized with default values!");
    
    self.name = @"Mr. Objective";
    self.age = 32;
    
    return self;
}

- (id)initWithName:(NSString *)name andAge:(int)age {
    
    NSLog(@"New PersonOBJC Initialized with custom values!");
    
    self.name = name;
    self.age = age;
    
    return self;
}

- (void)dealloc {
    
    // If required, perform deallocation here!
    NSLog(@"PersonOBJC Deallocation!");
}

@end
