//
//  BuyWebViewController.h
//  Letao
//
//  Created by Kaibin on 13-6-3.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "PPViewController.h"

@interface BuyWebViewController : PPViewController<UIWebViewDelegate>

@property (nonatomic, retain) UIWebView *webView;

- (void)openURL:(NSString *)URLString;

@end
