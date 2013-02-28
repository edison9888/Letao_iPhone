//
//  SinaWeiboManager.m
//  Letao
//
//  Created by Kaibin on 13-2-20.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "SinaWeiboManager.h"


@interface SinaWeiboManager()
@property (retain, nonatomic) NSString *appKey;
@property (retain, nonatomic) NSString *appRedirectURI;
@end


@implementation SinaWeiboManager
@synthesize sinaweibo = _sinaweibo;
@synthesize appKey = _appKey;
@synthesize appRedirectURI = _appRedirectURI;

- (void)dealloc
{
    [_sinaweibo release];
    [_appKey release];
    [_appRedirectURI release];
    [super dealloc];
}

+ (SinaWeiboManager *)sharedManager
{
    static SinaWeiboManager* _sharedManager = nil;
    @synchronized(self)
    {
        if (_sharedManager == nil) {
            _sharedManager = [[SinaWeiboManager alloc] init];
        }
        
    }
    return _sharedManager;
}

- (void)createSinaweiboWithAppKey:(NSString *)appKey
                        appSecret:(NSString *)appSecret
                   appRedirectURI:(NSString *)appRedirectURI
                         delegate:(id<SinaWeiboDelegate>)delegate
{
    self.appKey = appKey;
    self.appRedirectURI = appRedirectURI;
    
    SinaWeibo *tempSinaWeibo = [[SinaWeibo alloc] initWithAppKey:appKey appSecret:appSecret appRedirectURI:appRedirectURI andDelegate:delegate];
    self.sinaweibo = tempSinaWeibo;
    [tempSinaWeibo release];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        _sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        _sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        _sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
}

- (void)setDelegate:(id<SinaWeiboDelegate>)delegate
{
    self.sinaweibo.delegate = delegate;
}

- (void)storeAuthData
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}


@end

