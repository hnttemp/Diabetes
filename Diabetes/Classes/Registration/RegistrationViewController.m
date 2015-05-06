//
//  RegistrationViewController.m
//  Diabetes
//
//  Created by APPLE on 25/04/15.
//  Copyright (c) 2015 APPLE. All rights reserved.
//

#import "RegistrationViewController.h"
#define MAX_CHARACTER_RANGE 30

@interface RegistrationViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tfEmailId;
@property (weak, nonatomic) IBOutlet UITextField *tfUsername;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfMobileNo;
@property (weak, nonatomic) IBOutlet UITextView *tvAddress;

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnRegisterAction:(id)sender {
    if(!(_tfUsername.text && _tfPassword.text && _tfEmailId.text && _tfMobileNo.text && _tvAddress.text) ){
       [appShared showAlertWithTitle:@"Sorry" message:MSG_ENTER_REQUIRED];
       return;
    }
  
    NSDictionary *dicParam = @{
                               @"user_username" : _tfUsername.text,
                               @"user_email" : _tfEmailId.text,
                               @"user_password" : _tfPassword.text,
                               @"user_mobile"  : _tfMobileNo.text,
                               @"user_address"  : _tvAddress.text,
                               @"device_token"  : @"1234",
                               @"device_type"  : @"iPhone"
                              };
    
    [serviceManager executeServiceWithRequestUrl:[ URL_DOMAIN stringByAppendingString:URL_REGISTER ] WithParams:dicParam Method:RequestTypePost TaskId:kTaskUserRegister completionHandler:^(id response, NSError *error, TaskType task) {
        
        if([[[response objectAtIndex:0] valueForKey:@"message"] isEqualToString:@"Registred Successfully"]){
            NSLog(@"Registered successfully");
            [userDefualts setBool:YES forKey:KEY_USER_REGISTERED];
            [userDefualts setObject:dicParam forKey:KEY_USER_DETAIL];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
            [appShared showAlertWithTitle:@"Registration failed" message:[[response objectAtIndex:0] valueForKey:@"message"]];
    }];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - UITextfield delegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   if(textField.text.length <= MAX_CHARACTER_RANGE)
       return YES;
    else
    {
        [appShared showAlertWithTitle:@"" message:[NSString stringWithFormat:@"Only %d characters are allowed",MAX_CHARACTER_RANGE]];
        return NO;
    }
}
@end
