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
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 310, 30)];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text =  _article.title;
    [self.dataScrollView addSubview:titleLabel];
    _totalHeight += titleLabel.frame.size.height + 5;
    [titleLabel release];
    
    CGSize withinSize = CGSizeMake(300, CGFLOAT_MAX);
    NSString *content = _article.content;
    CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:withinSize lineBreakMode:UILineBreakModeWordWrap];
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _totalHeight, 300, size.height)];
    contentLabel.lineBreakMode = UILineBreakModeWordWrap;
    contentLabel.numberOfLines = 0;
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.text = _article.content;
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
