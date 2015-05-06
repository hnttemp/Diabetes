//
//  ServiceManager.m
//  HajjApp
//
//  Created by Amit Jain on 7/15/14.
//  Copyright (c) 2014 Amit Jain. All rights reserved.
//

#import "ServiceManager.h"
#import "AFSecurityPolicy.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"

static ServiceManager *sharedManager = nil;

@implementation ServiceManager

+(id)sharedManager{
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        if(sharedManager == nil){
            sharedManager = [[ServiceManager alloc] init];
        }
    });
    return sharedManager;
}

- (void)executeServiceWithRequestUrl:(NSString *)urlStr WithParams:(NSDictionary *)dicParams Method:(RequestHTTPMethod)requestHTTPMethod TaskId:(TaskType)taskId completionHandler:(void (^)(id response, NSError *error, TaskType task))completionBlock{
    NSLog(@"request = %@",urlStr);
    NSLog(@"with params = %@",dicParams);
    /*if(taskId != kTaskTypeDownloadImage)
    [appShared showLoadingView];
    if(taskId != kTaskTypeLogin && taskId != kTaskTypeDownloadImage){
        self.pendingRequest = urlStr;
        self.pendingReqParams = [dicParams mutableCopy];
        self.pendingTaskType = taskId;
    }*/
    
    if(requestHTTPMethod == RequestMethodGet){
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
        operation.taskId = taskId;
        operation.securityPolicy.allowInvalidCertificates = YES;
        
        /*if (taskId==kTaskGetAllDevices||taskId==kTaskVehicleTrackingCurrentLocation||taskId==kTaskVehicleTrackingWithSpecificDate) {
            operation.responseSerializer = [AFJSONResponseSerializer serializer];
            operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/jsonrequest"];
            
        }*/
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            [appShared hideActivityIndicator];
            completionBlock(responseObject,nil,taskId);
            NSLog(@"JSON or XML: %@", responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [appShared hideActivityIndicator];
         //   NSLog(@"error = %@",error.description);
            
            if ([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."]||[error.localizedDescription isEqualToString:@"Could not connect to the server."]) {
                [appShared showAlertWithTitle:@"" message:MSG_NO_INTERNET];
            }
            else {
                [appShared showAlertWithTitle:@"" message:error.localizedDescription];
            }
        }];
        
        [operation start];
        
    }else{
        AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
        [operationManager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        [operationManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
        [operationManager POST:urlStr parameters:dicParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [appShared hideActivityIndicator];
            NSLog(@"JSON: %@", responseObject);
           /* if([responseObject[@"status"] isEqualToString:@"6001"]){
                [self executeServiceWithRequestUrl:[NSString stringWithFormat:kUrlLogin,[userDefaults valueForKey:KEY_USER_ID]] WithParams:@{@"body":@{@"hardwareId":[userDefaults valueForKey:KEY_HARDWARE_ID]}} Method:RequestMethodPost TaskId:kTaskTypeLogin completionHandler:^(id response, NSError *error, TaskType task) {
                    if([response[@"status"] isEqualToString:@"1111"]){
                        NSString *newTokenStr = response[@"body"][@"token"];
                        [userDefaults setValue:newTokenStr forKey:KEY_TOKEN];
                        [self.pendingReqParams setValue:newTokenStr forKey:@"token"];
                        [self executeServiceWithRequestUrl:self.pendingRequest WithParams:self.pendingReqParams Method:RequestMethodPost TaskId:self.pendingTaskType completionHandler:^(id response, NSError *error, TaskType task) {
                            completionBlock(responseObject,nil,taskId);
                        }];
                    }else{
                        [appShared showAlertWithTitle:@"" Message:@"can not log in now try later"];
                    }
                }];
            }else{
                completionBlock(responseObject,nil,taskId);
            }*/
            
            completionBlock(responseObject,nil,taskId);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [appShared hideActivityIndicator]; 
            if ([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."]) {
                [appShared showAlertWithTitle:@"" message:MSG_NO_INTERNET];
            }
            else {
                [appShared showAlertWithTitle:@"" message:error.localizedDescription];
            }

            NSLog(@"error = %@",error.description);

            //completionBlock(nil,error,taskId);
        }];
    }
    
}
/*
- (void) updateUserLocationToServer :(CLLocation *)location {
    
    NSString *lati = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    NSString *longi = [NSString stringWithFormat:@"%f",location.coordinate.longitude];

    NSDictionary *dictParams = @{@"token":[userDefaults valueForKey:KEY_TOKEN],
                   @"body":@{
                           @"location":@{
                                   @"lat":lati,
                                   @"lon":longi
                                   },
                           }
                   };
    
    [serviceManager executeServiceWithRequestUrl:kUrlUpdateLocation WithParams:dictParams Method:RequestMethodPost TaskId:kTaskTypeUpdateUrl completionHandler:^(id response, NSError *error, TaskType task) {
        
    }];
}*/

- (BOOL)isOnline{
    AFNetworkReachabilityManager *reachablityManager = [AFNetworkReachabilityManager sharedManager];
    [reachablityManager startMonitoring];
    if([reachablityManager isReachable]){
        [reachablityManager stopMonitoring];
        return YES;
    }else{
        [reachablityManager stopMonitoring];
        return NO;
    }
}

@end
