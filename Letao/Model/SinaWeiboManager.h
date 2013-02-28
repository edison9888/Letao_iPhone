//
//  SinaWeiboManager.h
//  Letao
//
//  Created by Kaibin on 13-2-20.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SinaWeibo.h"

@interface SinaWeiboManager : NSObject

@property (retain, nonatomic) SinaWeibo *sinaweibo;

+ (SinaWeiboManager *)sharedManager;

- (void)createSinaweiboWithAppKey:(NSString *)appKey
                        appSecret:(NSString *)appSecret
                   appRedirectURI:(NSString *)appRedirectURI
                         delegate:(id<SinaWeiboDelegate>)delegate;

- (void)setDelegate:(id<SinaWeiboDelegate>)delegate;

- (void)storeAuthData;
- (void)removeAuthData;

@end
