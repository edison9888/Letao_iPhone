//
//  CommentViewController.m
//  Letao
//
//  Created by Kaibin on 13-3-18.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentService.h"
#import "TimeUtils.h"

@implementation CommentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"评论";
    
    UIButton *backButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)] autorelease];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];

    _textView = [[[UITextView alloc] initWithFrame:self.view.frame] autorelease];
    _textView.delegate = self;
    _textView.editable = YES;
    _textView.textColor = [UIColor blackColor];
    _textView.font = [UIFont systemFontOfSize:15];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.text = @"";
    [_textView becomeFirstResponder];
    
    _textView.returnKeyType = UIReturnKeyDefault;//返回键的类型
    _textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    _textView.scrollEnabled = YES;
    _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_textView];
}

- (void)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_textView release], _textView = nil;
    [_item_id release], _item_id = nil;
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    _textView = nil;
    _item_id = nil;
}

#pragma mark -
#pragma mark UITextView delegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    UIBarButtonItem *done = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(leaveEditMode)] autorelease];
    self.navigationItem.rightBarButtonItem = done;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)leaveEditMode
{
    [self.textView resignFirstResponder];
    Comment *comment = [[[Comment alloc] init] autorelease];
    comment.author = @"匿名用户";
    comment.content = _textView.text;
    comment.item_id = _item_id;
    [[CommentService sharedService] postComment:comment delegate:self];
}

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
