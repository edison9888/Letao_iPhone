//
//  AdService.h
//  Letao
//
//  Created by Kaibin on 13-5-12.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <immobSDK/immobView.h>
#import "DMAdView.h"
#import <MobWinBannerView.h>
#import "GlobalConstants.h"

@interface AdService : NSObject<immobViewDelegate>
{
    BOOL _isShowAd;
}

+ (AdService*)sharedService;

- (UIView*)createAdInView:(UIViewController*)superViewContoller frame:(CGRect)frame;

- (void)removeAdView:(UIView*)adView;

@end
