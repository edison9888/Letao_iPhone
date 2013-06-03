//
//  BuyWebViewController.m
//  Letao
//
//  Created by Kaibin on 13-6-3.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "BuyWebViewController.h"

@interface BuyWebViewController ()

@end

@implementation BuyWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        _webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [self.view addSubview:_webView];
        _webView.delegate = self;

    }    
    return self;
}

- (void)openURL:(NSString *)URLString
{
    [self showActivityWithText:NSLS(@"kLoadingURL")];
    NSLog(@"url = %@",URLString);
    
    NSURL *url = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *backButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)] autorelease];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];
}

- (void)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self hideTabBar];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self showTabBar];
}

- (void)dealloc
{
    [super dealloc];
    [_webView release], _webView = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self showActivityWithText:NSLS(@"kLoading")];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSLog(@"web view webViewDidFinishLoad");
    [self hideActivity];
    
}

@end
