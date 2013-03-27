//
//  SearchViewController.m
//  Letao
//
//  Created by Kaibin on 13-3-26.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "SearchViewController.h"
#import "UIImageUtil.h"
#import "UIViewUtils.h"
#import "UIUtils.h"
#import "ItemService.h"
#import "ItemViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage* searchTextFieldImage = [UIImage strectchableImageName:@"tu_46-18.png"];
    [_searchTextFieldBackgroundView setImage:searchTextFieldImage];
    
    UIImage* buttonBgImage = [UIImage strectchableImageName:@"tu_48.png"];
    [_searchButton setBackgroundImage:buttonBgImage forState:UIControlStateNormal];
    
    NSArray* keywords = [self getKeywords];
    
    UIButton* keywordTemplateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [keywordTemplateButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [keywordTemplateButton setTitleColor:[UIColor colorWithRed:(111/255.0) green:(104/255.0) blue:(94/255.0) alpha:1.0] forState:UIControlStateNormal];
    
    _wordsView = [[UIView alloc] initWithFrame:CGRectMake(15, 50, 290, 80)];
    [self.view addSubview:_wordsView];
    [_wordsView release];
    
    [_wordsView createButtonsInView:keywords templateButton:keywordTemplateButton target:self action:@selector(clickKeyword:)];
    [_wordsView setBackgroundColor:[UIColor clearColor]];
    
}

- (NSArray*)getKeywords
{
    return [NSArray arrayWithObjects: @"螺纹", @"润滑", @"摩擦", @"激情", @"凸点", @"超薄", @"颗粒", nil];
}

- (void)clickKeyword:(id)sender
{
    NSString* text = [((UIButton*)sender) currentTitle];
    
    if (_searchTextField.text == nil) {
        _searchTextField.text = text;
    }
    else {
        _searchTextField.text = [_searchTextField.text stringByAppendingString:text];
    }
}

- (IBAction) clickSearchButton:(id)sender
{
    if ([_searchTextField.text length] == 0) {
        [UIUtils alert:@"搜索关键字不能为空"];
        return;
    }
	[_searchTextField resignFirstResponder];
	[self search:_searchTextField.text];
}

- (void)search:(NSString*)keyword
{
    [[ItemService sharedService] search:keyword delegate:self];
}

- (void)viewDidUnload
{
    
}

- (void)viewDidAppear:(BOOL)animated
{
    int top = _wordsView.frame.origin.y + 80;
    [self addBlankView:top currentResponder:_searchTextField];
}

- (void)addBlankView:(CGFloat)top currentResponder:(UIView*)currentResponder
{
    CGRect frame = CGRectMake(0, top, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    if (self.blankView == nil){
        _blankView = [[UIBlankView alloc] initWithFrame:frame];
    }
    [_blankView removeFromSuperview];
    [_blankView registerKeyboardNotification:currentResponder fatherView:self.view frame:frame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_wordsView release]; _wordsView = nil;
    [_searchTextFieldBackgroundView release]; _searchTextFieldBackgroundView = nil;
    [_searchButton release]; _searchButton = nil;
    [_searchTextField release]; _searchTextField = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark - RKObjectLoaderDelegate

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    NSLog(@"Response code: %d", [response statusCode]);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", [error localizedDescription]);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    NSLog(@"***Load objects count: %d", [objects count]);
    ItemViewController *controller = [[ItemViewController alloc] initWithData:objects];
    controller.title = @"结果";
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}


@end
