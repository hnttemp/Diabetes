//
//  AppShared.h
//  Diabetes
//
//  Created by APPLE on 23/04/15.
//  Copyright (c) 2015 APPLE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomAlertView.h"

@interface AppShared : NSObject
@property (nonatomic, strong) CustomAlertView *customAlert;

+(AppShared*) sharedInstance;
- (void) showActivityIndicatorWithTitle:(NSString*)title message:(NSString*)message onView:(UIView*)parentView;
- (void) hideActivityIndicator;
- (void) showAlertWithTitle:(NSString*)title message:(NSString*)message;

@end
