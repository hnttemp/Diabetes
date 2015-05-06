//
//  AppShared.m
//  Diabetes
//
//  Created by APPLE on 23/04/15.
//  Copyright (c) 2015 APPLE. All rights reserved.
//

#import "AppShared.h"

@implementation AppShared
AppShared *appSharedData;

+(AppShared*)sharedInstance
{
    dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        appSharedData = [[AppShared alloc] init];
    });
    return appSharedData;
}

- (void) showActivityIndicatorWithTitle:(NSString*)title message:(NSString*)message onView:(UIView*)parentView{
    
    [self hideActivityIndicator];
    self.customAlert = [[CustomAlertView alloc]initWithTitle:title message:message];
    [self.customAlert setCenter:parentView.center];
    [parentView addSubview:self.customAlert];
    [parentView setUserInteractionEnabled:NO];
    [self.customAlert startAnimating];
}

- (void) hideActivityIndicator{
    if(self.customAlert){
        [[self.customAlert superview] setUserInteractionEnabled:YES];
        [self.customAlert removeFromSuperview];
        self.customAlert = nil;
    }
}

- (void) showAlertWithTitle:(NSString*)title message:(NSString*)message{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    alert = nil;
}

@end
