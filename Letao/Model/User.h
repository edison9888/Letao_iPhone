//
//  User.h
//  Letao
//
//  Created by Kaibin on 13-6-11.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, retain) NSString *userId;
//@property (nonatomic, retain) NSString *loginId;
//@property (nonatomic, retain) NSNumber *loginIdType;
@property (nonatomic, retain) NSString *nickName;
@property (nonatomic, retain) NSString *avatar;
@property (nonatomic, retain) NSString *sinaAccessToken;
@property (nonatomic, retain) NSString *sinaAccessTokenSecret;
@property (nonatomic, retain) NSString *qqAccessToken;
@property (nonatomic, retain) NSString *qqAccessTokenSecret;
@property (nonatomic, assign) NSNumber *loginStatus;

@property (nonatomic, retain) NSString *userLoginId;
@property (nonatomic, retain) NSString *sinaLoginId;
@property (nonatomic, retain) NSString *qqLoginId;
@property (nonatomic, retain) NSString *renrenLoginId;
@property (nonatomic, retain) NSString *facebookLoginId;
@property (nonatomic, retain) NSString *twitterLoginId;

@end
