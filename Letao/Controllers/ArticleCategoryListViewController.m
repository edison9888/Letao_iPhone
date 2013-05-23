//
//  ArticleCategoryListViewController.m
//  Letao
//
//  Created by Kaibin on 13-5-23.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "ArticleCategoryListViewController.h"
#import "ArticleService.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "ArticleCategoryCell.h"
#import "ArticleCategory.h"
#import "ArticleListViewController.h"

@interface ArticleCategoryListViewController ()

@end

@implementation ArticleCategoryListViewController

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
    [[ArticleService sharedService] findArticleCategory:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [ArticleCategoryCell heightForCell];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ArticleCategoryCell";
    
    ArticleCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[ArticleCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if ([self.dataList count] > 0) {
        ArticleCategory *category = [self.dataList objectAtIndex:indexPath.row];
        [cell setCategory:category];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleListViewController *controller = [[ArticleListViewController alloc] init];
    controller.cat_id = [NSString stringWithFormat:@"%d",indexPath.row+1];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
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
