//
//  PersonOBJC.h
//  Singleton
//
//  Created by Kevin Harris on 10/17/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

#ifndef PersonOBJC_h
#define PersonOBJC_h

#import <UIKit/UIKit.h>

@interface PersonOBJC : NSObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic) int age;

- (id)init;

- (id)initWithName:(NSString *)name andAge:(int)age;

- (void)dealloc;

@end

#endif /* PersonOBJC_h */
