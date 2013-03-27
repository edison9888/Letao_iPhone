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
                     viewTitle:@"精品"
                     viewImage:@"home"
                    hasNavController:YES
                    viewControllers:controllers];
    
    [UIUtils addViewController:[BrandListViewController alloc]
                     viewTitle:@"品牌"
                     viewImage:@"cabinet"
                    hasNavController:YES
                    hideNavigationBar:NO
                    viewControllers:controllers];
    
    [UIUtils addViewController:[FavouriteViewController alloc]
                     viewTitle:@"喜欢"
                     viewImage:@"love"
                    hasNavController:YES
                    hideNavigationBar:NO
                    viewControllers:controllers];
    
    [UIUtils addViewController:[SearchViewController alloc]
                     viewTitle:@"搜索"
                     viewImage:@"magnify"
                    hasNavController:YES
                    hideNavigationBar:NO
                    viewControllers:controllers];
    
    
    _tabBarController.viewControllers = controllers;
    _tabBarController.selectedIndex = 0;
    [controllers release];
    
    
}

- (void)configureAppearance
{
    UIImage *barImage = [UIImage imageNamed:@"bar-background"];
    [[UINavigationBar appearance] setBackgroundImage:barImage forBarMetrics:UIBarMetricsDefault];
    [[UIToolbar appearance] setBackgroundImage:barImage forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
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

@end
