//
//  Constant.h
//  Diabetes
//
//  Created by APPLE on 23/04/15.
//  Copyright (c) 2015 APPLE. All rights reserved.
//

#ifndef Diabetes_Constant_h
#define Diabetes_Constant_h

/********    messages   ********/

#define MSG_NO_INTERNET @"Please check your internet connection"
#define MSG_ENTER_USERNAME @"Please enter username"
#define MSG_ENTER_PASSWORD @"Please enter password"
#define MSG_ENTER_REQUIRED @"Please fill required Fields"
#define MSG_WENT_WRONG @"Something went wrong"

/********    Keys   ********/
#define KEY_USER_REGISTERED @"isUserRegistered"
#define KEY_USER_DETAIL @"userDetails"

/********    Enum   ********/
typedef enum{
    kTaskLogin,
    kTaskUserRegister,
    kTaskLogout
}TaskType;

typedef enum{
    RequestMethodGet,
    RequestTypePost
}RequestHTTPMethod;

#endif
