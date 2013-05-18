//
//  AdService.m
//  Letao
//
//  Created by Kaibin on 13-5-12.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "AdService.h"
#import "DeviceDetection.h"

#define AD_VIEW_TAG    20130512

@implementation AdService


+ (AdService*)sharedService
{
    static AdService *_sharedService = nil;
    @synchronized(self)
    {
        if (_sharedService == nil) {
            _sharedService = [[AdService alloc] init];
        }
    }
    return _sharedService;
}

- (BOOL)isShowAd
{
    return YES;
}

- (UIView*)createAdInView:(UIViewController*)superViewContoller
                    frame:(CGRect)frame
{
    
    if ([self isShowAd] == NO){
        NSLog(@"<createAdView> but ad is disabled");
        return nil;
    }
    
    NSLog(@"<createAdView>");
//    return [self createImmobAdInView:superViewContoller.view
//                            appId:IMMOB_APP_ID
//                            frame:frame];
//    return [self createDomobAdInView:superViewContoller
//                      publisherId:DOMOB_PUBLISH_ID
//                            frame:frame];
    
    return [self createMobWinAdInView:superViewContoller
                      adUnitID:MOBWIN_AD_UNIT_ID
                            frame:frame];

    
}

- (void)removeAdView:(UIView*)adView
{
    if (adView == nil || adView.superview == nil) {
        return;
    }
    @try {
        [adView removeFromSuperview];
    }
    @catch (NSException *exception) {
        NSLog(@"<removeAdView> catch exception=%@", [exception description]);
    }
    @finally {
        
    }
}

- (UIView*)createDomobAdInView:(UIViewController*)superViewContoller
                      publisherId:(NSString*)publisherId
                      frame:(CGRect)frame
{
    DMAdView *dmAdView = [[DMAdView alloc] initWithPublisherId:publisherId size:DOMOB_AD_SIZE_320x50];
    [dmAdView setFrame:CGRectMake(frame.origin.x,frame.origin.y, DOMOB_AD_SIZE_320x50.width, DOMOB_AD_SIZE_320x50.height)];
    dmAdView.rootViewController = superViewContoller; 
    [superViewContoller.view addSubview:dmAdView]; 
    [dmAdView loadAd]; 
    return dmAdView;
}

- (UIView*)createMobWinAdInView:(UIViewController*)superViewContoller
                adUnitID:(NSString*)adUnitID
                      frame:(CGRect)frame
{
    MobWinBannerView *adBanner = [MobWinBannerView instance];
    adBanner.adSizeIdentifier = MobWINBannerSizeIdentifier320x50;
    [adBanner setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    adBanner.rootViewController = superViewContoller;
    [superViewContoller.view addSubview:adBanner];
    adBanner.adUnitID = adUnitID;
    [adBanner startRequest];
    return adBanner;

}

- (UIView*)createImmobAdInView:(UIView*)superView
                      appId:(NSString*)appId
                      frame:(CGRect)frame
{
    immobView* adView = nil;
    adView = [[[immobView alloc] initWithAdUnitID:appId] autorelease];
    [adView setFrame:frame];
    adView.backgroundColor = [UIColor clearColor];
    adView.delegate = self;
    [adView immobViewRequest];
    [superView addSubview:adView];
    [adView immobViewDisplay];
    return adView;
}

@end
