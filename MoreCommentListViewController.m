//
//  MoreCommentListViewController.m
//  Letao
//
//  Created by Kaibin on 13-5-18.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "MoreCommentListViewController.h"
#import "CommentService.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "CommentCell.h"
#import "CommentViewController.h"

#define TITLE_COLOR [UIColor blackColor]
#define DESCRIPTION_COLOR [UIColor blackColor]
#define BG_COLOR [UIColor colorWithWhite:1 alpha:0.3f]

@implementation MoreCommentListViewController

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
    self.title = NSLS(@"kAllComments");
    
    UIButton *backButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)] autorelease];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];
    
    UIButton *commentButon = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)] autorelease];
    [commentButon setImage:[UIImage imageNamed:@"edit@2x"] forState:UIControlStateNormal];
    [commentButon addTarget:self action:@selector(addComment:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:commentButon] autorelease];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self reloadTableViewDataSource];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) reloadTableViewDataSource
{
    [[CommentService sharedService] findCommentsWithItemId:_itemid delegate:self];
}

- (void)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addComment:(id)sender
{
    CommentViewController *controller = [[[CommentViewController alloc] init] autorelease];
    controller.item_id = _itemid;
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark -
#pragma mark TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger size;
    if ([self.dataList count] > 0) {
        size = [self.dataList count];
    } else {
        size = 0;
    }
    return size;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CommentCell heightForCell];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CommentCell";
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    [cell setBackgroundColor:BG_COLOR];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if ([self.dataList count] > 0) {
        Comment *comment = [self.dataList objectAtIndex:indexPath.row];
        [cell setComment:comment rowIndex:indexPath.row];
    }
    return cell;
}


#pragma mark -
#pragma mark - RKObjectLoaderDelegate

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    NSLog(@"Response code: %d", [response statusCode]);
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", [error localizedDescription]);
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)requestDidStartLoad:(RKRequest *)request
{
    NSLog(@"Start load request...");
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = NSLS(@"kLoading");
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    self.dataList = objects;
    NSLog(@"***Total comments count: %d", [self.dataList count]);
    [self.dataTableView reloadData];
}


@end
