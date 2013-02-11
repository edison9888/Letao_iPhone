//
//  AppDelegate.h
//  Letao
//
//  Created by Callon Tom on 13-1-27.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPApplication.h"

@class MainController;

@interface AppDelegate : PPApplication <UIApplicationDelegate, UITabBarControllerDelegate>

@property (retain, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainController *mainController;
@property (strong, nonatomic) UITabBarController *tabBarController;


@end
