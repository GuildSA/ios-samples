//
//  UtilityOBJC.h
//  Singleton
//
//  Created by Kevin Harris on 10/17/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

#ifndef UtilityOBJC_h
#define UtilityOBJC_h

#import <UIKit/UIKit.h>

@interface UtilityOBJC : NSObject

@property (nonatomic, retain) NSString *someProperty;

// This gives access to the one and only instance.
+ (id)sharedInstance;

+ (bool)isValidEmail:(NSString *)emailAddress;

+ (void)showAlert:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message;

+ (void)delayTask:(double)seconds task:(void(^)(void))task;

@end

#endif /* UtilityOBJC_h */
