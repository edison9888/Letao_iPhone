//
//  ShareToWeixinControllerViewController.m
//  Letao
//
//  Created by Kaibin on 13-4-14.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "ShareToWeixinController.h"
#import "DeviceDetection.h"
#import "WXApi.h"
#import "GlobalConstants.h"
#import "UIUtils.h"

@interface ShareToWeixinController ()

@end

@implementation ShareToWeixinController

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
    
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleBordered target:self action:@selector(sendMsgToWexin:)];
	self.navigationItem.rightBarButtonItem = barButtonItem;
	[barButtonItem release];
    
    self.navigationItem.title = @"分享到微信";
    
    [self showSendView];
    
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

#define WORDSNUMBER_WIDTH   30
#define WORDSNUMBER_HEIGHT  20
#define CONTENT_WIDTH       284
#define CONTENT_HEIGHT      132

- (void)showSendView
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((320-CONTENT_WIDTH)/2+CONTENT_WIDTH-WORDSNUMBER_WIDTH, 30-WORDSNUMBER_HEIGHT, WORDSNUMBER_WIDTH, WORDSNUMBER_HEIGHT)];
    label.text = @"0";
    label.textAlignment = UITextAlignmentRight;
    label.textColor = [UIColor whiteColor];
    //label.backgroundColor = [UIColor blueColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12];
    self.wordsNumberLabel = label;
    [label release];
    
    UIImageView *textBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"feedback_bg2.png"]];
    textBackgroundView.frame = CGRectMake((320-CONTENT_WIDTH)/2, 30, CONTENT_WIDTH, CONTENT_HEIGHT);
    [self.view addSubview:textBackgroundView];
    [textBackgroundView release];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake((320-CONTENT_WIDTH)/2, 30, CONTENT_WIDTH, CONTENT_HEIGHT)];
    textView.delegate = self;
    textView.font = [UIFont systemFontOfSize:14];
    
    NSString *path = [_item.imageList objectAtIndex:0];;
    if (![path hasPrefix:@"http"]) {
        textView.text = [NSString stringWithFormat:@"我通过”套套大全“发现了一款有趣的安全套:%@\n%@",_item.title, @"http://durex-china.taobao.com/"];
    } else {
        textView.text = [NSString stringWithFormat:@"我通过”套套大全“发现了一款有趣的安全套:%@\n%@",_item.title, _item.buy_url];
    }
    
    textView.backgroundColor = [UIColor clearColor];
    self.contentTextView = textView;
    [textView release];
    
    [self.view addSubview:_wordsNumberLabel];
    [self.view addSubview:_contentTextView];
    
    self.wordsNumberLabel.text = [NSString stringWithFormat:@"%d",[_contentTextView.text length]];
}

- (void)sendMsgToWexin:(id)sender
{
    if ([WXApi isWXAppInstalled] == NO || [WXApi isWXAppSupportApi] == NO)
    {
        [UIUtils alert:@"对不起，您没有安装微信或微信版本较低，无法发送微信消息!"];
    }else{
        [_contentTextView resignFirstResponder];
        NSLog(@"send msg to weixin!");
        
//        NSString *path = [_item.imageList objectAtIndex:0];;
//        if (![path hasPrefix:@"http"]) {
//            path = [DUREX_IMAGE_BASE_URL stringByAppendingString:path];
//        }
//        UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:path]]];
//        WXMediaMessage *message = [WXMediaMessage message];
//        [message setThumbImage:image];
//        
//        WXImageObject *ext = [WXImageObject object];
//        NSString *filePath = path;
//        ext.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:filePath]];
//        message.mediaObject = ext;
//        
//        SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
//        req.bText = NO;
//        req.message = message;
//        req.scene = _scene;  //选择发送到朋友圈，默认值为WXSceneSession，发送到会话
//        [WXApi sendReq:req];
        
               
        SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
        req.bText = YES;
        req.text = _contentTextView.text;
        req.scene = _scene;
        [WXApi sendReq:req];
    }
}

#pragma -mark UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    self.wordsNumberLabel.text = [NSString stringWithFormat:@"%d",[textView.text length]];
}

@end
