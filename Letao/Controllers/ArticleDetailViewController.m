//
//  ArticleDetailViewController.m
//  Letao
//
//  Created by Kaibin on 13-4-4.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "ArticleDetailViewController.h"

@interface ArticleDetailViewController ()

@end

@implementation ArticleDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithArticle:(Article*)article
{
    self = [super init];
    if (self) {
        self.article = article;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"详情";
    
    UIButton *backButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)] autorelease];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    UIImage *bgImage = [UIImage imageNamed:@"section-bar2"];
    bgView.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    [_dataScrollView addSubview:bgView];
    [bgView release];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 310, 30)];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text =  _article.title;
    titleLabel.textColor = [UIColor blackColor];
    [self.dataScrollView addSubview:titleLabel];
    _totalHeight += titleLabel.frame.size.height + 5;
    [titleLabel release];
    
    CGSize withinSize = CGSizeMake(300, CGFLOAT_MAX);
    NSRange range = NSMakeRange(1, [_article.content length]-1);
    NSString *content = [_article.content stringByReplacingOccurrencesOfString:@"【" withString:@"\n【" options:NSCaseInsensitiveSearch range:range];
    CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:withinSize lineBreakMode:UILineBreakModeWordWrap];
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _totalHeight, 300, size.height)];
    contentLabel.lineBreakMode = UILineBreakModeWordWrap;
    contentLabel.numberOfLines = 0;
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.text = content;
    [self.dataScrollView addSubview:contentLabel];
    _totalHeight += contentLabel.frame.size.height + 5;
    [contentLabel release];

    [_dataScrollView setContentSize:CGSizeMake(self.view.frame.size.width, _totalHeight)];
}

- (void)viewDidUnload
{
    _article = nil;
}

- (void)dealloc
{
    [_article release], _article = nil;
    [super dealloc];
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




@end
