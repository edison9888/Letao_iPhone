//
//  AppDelegate.m
//  Letao
//
//  Created by Callon Tom on 13-1-27.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "AppDelegate.h"
#import "ItemViewController.h"
#import "BrandListViewController.h"
#import "FavouriteViewController.h"
#import "DeviceDetection.h"
#import "UIUtils.h"
#import "GlobalConstants.h"
#import "SearchViewController.h"
#import "ArticleCategoryListViewController.h"
#import "Reachability.h"
#import "MobClick.h"
#import "LocaleUtils.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_mainController release];
    [_tabBarController release];
    [_window release];
    [super dealloc];
}

- (void)initTabViewControllers
{
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    self.tabBarController = tabBarController;
    [tabBarController release];
    
    _tabBarController.delegate = self;
    
    NSMutableArray* controllers = [[NSMutableArray alloc] init];
    
    [UIUtils addViewController:[ItemViewController alloc]
                     viewTitle:NSLS(@"kRecommend")
                     viewImage:@"home"
                    hasNavController:YES
                    viewControllers:controllers];
    
    [UIUtils addViewController:[BrandListViewController alloc]
                     viewTitle:NSLS(@"kBrand")
                     viewImage:@"cabinet"
                    hasNavController:YES
                    hideNavigationBar:NO
                    viewControllers:controllers];
    
    [UIUtils addViewController:[FavouriteViewController alloc]
                     viewTitle:NSLS(@"kStar")
                     viewImage:@"star"
                    hasNavController:YES
                    hideNavigationBar:NO
                    viewControllers:controllers];
    
    [UIUtils addViewController:[SearchViewController alloc]
                     viewTitle:NSLS(@"kSearch")
                     viewImage:@"magnify"
                    hasNavController:YES
                    hideNavigationBar:NO
                    viewControllers:controllers];
    
    [UIUtils addViewController:[ArticleCategoryListViewController alloc]
                     viewTitle:NSLS(@"kArticle")
                     viewImage:@"text-list"
                    hasNavController:YES
                    hideNavigationBar:NO
                    viewControllers:controllers];
    
    
    _tabBarController.viewControllers = controllers;
    _tabBarController.selectedIndex = 0;
    [controllers release];
    
    
}

- (void)configureAppearance
{
    UIImage *barImage = [UIImage imageNamed:@"navigationbar_background"];
    [[UINavigationBar appearance] setBackgroundImage:barImage forBarMetrics:UIBarMetricsDefault];
    [[UIToolbar appearance] setBackgroundImage:barImage forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NSLS(@"kTips") message:NSLS(@"kNoNetwork") delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
    //Weixin
    [WXApi registerApp:WEIXIN_APP_KEY];
    
    //UMeng
    [MobClick startWithAppkey:UMENG_KEY];
    [MobClick updateOnlineConfig];

    //HJCache
    [self initImageCacheManager];
    
    //RestKit
    RKURL *baseURL = [RKURL URLWithBaseURLString:SERVER_URL];
    RKObjectManager *objectManager = [RKObjectManager objectManagerWithBaseURL:baseURL];
    objectManager.acceptMIMEType = RKMIMETypeJSON;
    objectManager.serializationMIMEType = RKMIMETypeJSON;
    objectManager.client.baseURL = baseURL;

    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self initTabViewControllers];
    [self configureAppearance];
    self.window.rootViewController  = _tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//onReq是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用sendRsp返回。在调用sendRsp返回时，会切回到微信终端程序界面。
-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]]) {
        // TODO 微信请求内容，目前不需要回应
    }
    
    else if([req isKindOfClass:[ShowMessageFromWXReq class]]) {
        // TODO 微信发过来的内容
    }
}

//如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，会切到微信终端程序界面。
-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        if (resp.errCode == WXSuccess){
            [UIUtils alert:NSLS(@"kShareToWeixinSuccessfully")];
            NSLog(@"<onResp> weixin response success");
        }else {
            NSLog(@"<onResp> weixin response fail");
        }
    }
}


@end
