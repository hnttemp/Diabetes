//
//  ServiceManager.h
//  HajjApp
//
//  Created by Amit Jain on 7/15/14.
//  Copyright (c) 2014 Amit Jain. All rights reserved.
//

#import <Foundation/Foundation.h>
//@protocol ServiceManagerDelegate <NSObject>
//
//- (void)serviceExecutedWithResponse:(id)response ForTaskId:(TaskType)taskId;
//- (void)serviceFailedWithError:(id)error;
//
//@end

@interface ServiceManager : NSObject<NSXMLParserDelegate>

+ (id)sharedManager;
- (void)executeServiceWithRequestUrl:(NSString *)urlStr WithParams:(NSDictionary *)dicParams Method:(RequestHTTPMethod)requestHTTPMethod TaskId:(TaskType)taskId completionHandler:(void (^)(id response, NSError *error, TaskType task))completionBlock;
//- (void) updateUserLocationToServer :(CLLocation *)location;
//@property (nonatomic, assign) id<ServiceManagerDelegate>delegate;
@property (nonatomic, strong) NSString *pendingRequest;
@property (nonatomic, strong) NSMutableDictionary *pendingReqParams;
@property (nonatomic, assign) TaskType pendingTaskType;
- (BOOL)isOnline;


@end
