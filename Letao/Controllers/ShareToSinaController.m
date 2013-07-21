//
//  ShareToSinaController.m
//  Letao
//
//  Created by Kaibin on 13-2-20.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "ShareToSinaController.h"
#import "DeviceDetection.h"
#import "GlobalConstants.h"
#import "Item.h"
#import "Reachability.h"
#import "TKAlertCenter.h"

@implementation ShareToSinaController

- (id)init
{
    self = [super init];
    if (self) {
        
    }    
    return self;
}

- (id)initWithItem:(Item*)item
{
    self = [super init];
    if (self) {
        _item = item;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *allBackgroundImage = nil;
    if ([DeviceDetection isIPhone5]) {
        allBackgroundImage = [UIImage imageNamed:@"all_page_bg2_i5.jpg"];
    } else {
        allBackgroundImage =  [UIImage imageNamed:@"all_page_bg2.jpg"];
    }
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:allBackgroundImage]];
    
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleBordered target:self action:@selector(sendSinaWeibo:)];
	self.navigationItem.rightBarButtonItem = barButtonItem;
	[barButtonItem release];
    
    self.navigationItem.title = @"分享到新浪微博";
    
    [self showSendView];
        
    _sinaweiboManager = [SinaWeiboManager sharedManager];
    [_sinaweiboManager createSinaweiboWithAppKey:SINA_WEIBO_APP_KEY appSecret:SINA_WEIBO_APP_SECRET appRedirectURI:kAppRedirectURI delegate:self];
    
    if (![_sinaweiboManager.sinaweibo isAuthValid]) {
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
//        [_sinaweiboManager.sinaweibo logInInView:self.view];
        [_sinaweiboManager.sinaweibo logIn];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_contentTextView release];
    [_wordsNumberLabel release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    [self setContentTextView:nil];
    [self setWordsNumberLabel:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = YES;
    [super viewDidAppear:animated];
}

#define WEIBO_LOGO_WIDTH    98
#define WEIBO_LOGO_HEIGHT   30
#define WORDSNUMBER_WIDTH   30
#define WORDSNUMBER_HEIGHT  20
#define CONTENT_WIDTH       284
#define CONTENT_HEIGHT      132

- (void)showSendView
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((320-CONTENT_WIDTH)/2, 0, WEIBO_LOGO_WIDTH, WEIBO_LOGO_HEIGHT)];
    imageView.image = [UIImage imageNamed:@"SinaWeibo_logo.png"];
    [self.view addSubview:imageView];
    [imageView release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((320-CONTENT_WIDTH)/2+CONTENT_WIDTH-WORDSNUMBER_WIDTH, WEIBO_LOGO_HEIGHT-WORDSNUMBER_HEIGHT, WORDSNUMBER_WIDTH, WORDSNUMBER_HEIGHT)];
    label.text = @"0";
    label.textAlignment = UITextAlignmentRight;
    label.textColor = [UIColor whiteColor];
    //label.backgroundColor = [UIColor blueColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12];
    self.wordsNumberLabel = label;
    [label release];
    
    UIImageView *textBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"feedback_bg2.png"]];
    textBackgroundView.frame = CGRectMake((320-CONTENT_WIDTH)/2, WEIBO_LOGO_HEIGHT, CONTENT_WIDTH, CONTENT_HEIGHT);
    [self.view addSubview:textBackgroundView];
    [textBackgroundView release];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake((320-CONTENT_WIDTH)/2, WEIBO_LOGO_HEIGHT, CONTENT_WIDTH, CONTENT_HEIGHT)];
    textView.delegate = self;
    textView.font = [UIFont systemFontOfSize:14];
    textView.text = [NSString stringWithFormat:@"我通过”套套大全“发现了一款有趣的安全套:%@",_item.title];
    textView.backgroundColor = [UIColor clearColor];
    self.contentTextView = textView;
    [textView release];
    
    [self.view addSubview:_wordsNumberLabel];
    [self.view addSubview:_contentTextView];
    
    self.wordsNumberLabel.text = [NSString stringWithFormat:@"%d",[_contentTextView.text length]];
}

- (void)sendSinaWeibo:(id)sender
{
    [_contentTextView resignFirstResponder];
    
    if ([_sinaweiboManager.sinaweibo isAuthValid]) {
        
        NSString *path = [_item.imageList objectAtIndex:0];;
        if (![path hasPrefix:@"http"]) {
            path = [DUREX_IMAGE_BASE_URL stringByAppendingString:path];
        }
        
        if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == ReachableViaWWAN){
            UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:path]]];
            
            //发送微博,wifi下发图片
            [_sinaweiboManager.sinaweibo requestWithURL:@"statuses/upload.json"
                                                 params:[NSMutableDictionary dictionaryWithObjectsAndKeys: _contentTextView.text, @"status", image, @"pic",nil]
                                             httpMethod:@"POST"
                                               delegate:self];
        }
        else {
            //发送微博,非wifi下只发文本
            [_sinaweiboManager.sinaweibo requestWithURL:@"statuses/update.json"
                                                 params:[NSMutableDictionary dictionaryWithObjectsAndKeys: _contentTextView.text, @"status",nil]
                                             httpMethod:@"POST"
                                               delegate:self];
        }
        
        
        [self showActivity];
    } else {
        [_sinaweiboManager.sinaweibo logInInView:self.view];
    }
}

#pragma -mark UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    self.wordsNumberLabel.text = [NSString stringWithFormat:@"%d",[textView.text length]];
}

#pragma mark -
#pragma SinaWeiboDelegate methods
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    
    [_sinaweiboManager storeAuthData];
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
    [_sinaweiboManager removeAuthData];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    [_sinaweiboManager removeAuthData];
}

#pragma mark -
#pragma SinaWeiboRequestDelegate methods
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"requestDidFailWithError:%@",error);
    [self hideActivity];
    
    if (error.code == 20019) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"不能重复发送相同的内容"];

    } else {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"发送失败"];

    }
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    NSLog(@"requestDidFinishLoadingWithResult:%@", result);
    [self hideActivity];
    [[TKAlertCenter defaultCenter] postAlertWithMessage:@"发送成功"];

}



@end
