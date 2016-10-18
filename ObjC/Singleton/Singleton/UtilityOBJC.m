//
//  UtilityOBJC.m
//  Singleton
//
//  Created by Kevin Harris on 10/17/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UtilityOBJC.h"

@implementation UtilityOBJC

@synthesize someProperty;

#pragma mark Singleton Methods

+ (id)sharedInstance {
    
    static UtilityOBJC *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (id)init {
    
    self = [super init];
 
    return self;
}

+ (bool)isValidEmail:(NSString *)emailAddress {
 
    NSString *emailFormat = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}";
    
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailFormat];
    
    return [emailPredicate evaluateWithObject: emailAddress];
}

+ (void)showAlert:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: title message: message preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction * okAction = [UIAlertAction actionWithTitle: @"OK" style: UIAlertActionStyleDefault
                         handler: ^(UIAlertAction * action) {

                             NSLog(@"Ok button selected!");
                         }];
    
    [alertController addAction: okAction];
    
    [viewController presentViewController: alertController animated: YES completion: nil];
}

+ (void)delayTask:(double)seconds task:(void(^)(void))task {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        task();
    });
}

@end

