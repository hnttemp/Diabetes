//
//  CustomAlertView.h
//  AllenPort
//
//  Created by MAC23 on 04/08/11.
//  Copyright 2011 Diaspark India. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertView : UIView {
    UIActivityIndicatorView *_activity;
    BOOL _hidden;
    
    NSString *_title;
    NSString *_message;
    float radius;
}

@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *message;
@property (assign,nonatomic) float radius;

- (id) initWithTitle:(NSString*)title message:(NSString*)message;
- (id) initWithTitle:(NSString*)title;

- (void) startAnimating;
- (void) stopAnimating;

- (void)setCenterForOrientation:(UIInterfaceOrientation)orientation ;

@end
