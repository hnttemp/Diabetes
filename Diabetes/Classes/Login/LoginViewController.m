//
//  LoginViewController1.m
//  Diabetes
//
//  Created by H&T on 06/05/15.
//  Copyright (c) 2015 APPLE. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

#import "LoginViewController.h"
#import "RegistrationViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tfUsername;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*check user registered already registered or not*/
    if(![userDefualts valueForKey:KEY_USER_REGISTERED])
    {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RegistrationViewController *registrationVC = [storyBoard instantiateViewControllerWithIdentifier:@"RegistrationViewController"];
        [self presentViewController:registrationVC animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnLoginAction:(id)sender {
    
    if([self.tfUsername.text isEqualToString:@""] || [self.tfUsername.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] == nil)
    {
        [appShared showAlertWithTitle:@"" message:MSG_ENTER_USERNAME];
        return;
    }
    
    if([self.tfPassword.text isEqualToString:@""] || [self.tfPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] == nil)
    {
        [appShared showAlertWithTitle:@"" message:MSG_ENTER_PASSWORD];
        return;
    }
    
    NSDictionary *dicParam = @{
                               @"user_email"    : self.tfUsername.text,
                               @"user_password" : self.tfPassword.text,
                               @"device_token"  : [[UIDevice currentDevice] identifierForVendor].UUIDString,
                               @"device_type"   : @"iPhone"
                               };
    
    [appShared showActivityIndicatorWithTitle:@"Please wait" message:@"logging in..." onView:self.view];
    [serviceManager executeServiceWithRequestUrl:[URL_DOMAIN stringByAppendingString:URL_LOGIN] WithParams:dicParam Method:RequestTypePost TaskId:kTaskLogin completionHandler:^(id response, NSError *error, TaskType task) {
        NSLog(@"login response : %@",response);
    }];
}

@end
