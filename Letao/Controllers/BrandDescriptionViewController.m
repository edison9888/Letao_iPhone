//
//  BrandDescriptionViewController.m
//  Letao
//
//  Created by Kaibin on 13-3-2.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "BrandDescriptionViewController.h"

@implementation BrandDescriptionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithBrand:(Brand*)brand
{
    self = [super init];
    if (self) {
        self.brand = brand;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"品牌介绍";
    UIButton *backButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)] autorelease];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];
    
    self.textView = [[UITextView alloc] initWithFrame:self.view.frame]; 
//    self.textView.delegate = self;
    self.textView.editable = NO;
    self.textView.textColor = [UIColor blackColor];
    self.textView.font = [UIFont systemFontOfSize:15];
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.text = self.brand.introduction;
    self.textView.scrollEnabled = YES;
    self.textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview: self.textView];
}

- (void)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.brand = nil;
    self.textView = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self hideTabBar];
    [super viewDidAppear:animated];
}

- (void)viewDidDisAppear:(BOOL)animated
{
    [self showTabBar];
    [self viewDidDisappear:animated];
}

- (void)dealloc
{
    [self.brand release]; self.brand = nil;
    [self.textView release]; self.textView = nil;
    [super dealloc];
}

@end
