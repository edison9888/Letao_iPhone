//
//  BrandListViewController.m
//  Letao
//
//  Created by Kaibin on 13-2-13.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "BrandListViewController.h"
#import "BrandService.h"
#import "Brand.h"
#import "ItemViewController.h"

@interface BrandListViewController ()

@end

@implementation BrandListViewController

- (id)init
{
    self = [super init];
    if (self) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:65/255.0 green:105/255.0 blue:225/255.0 alpha:1.0];
//    self.navigationController.navigationBar.layer.shadowColor = [[UIColor colorWithRed:65/255.0 green:105/255.0 blue:225/255.0 alpha:1.0] CGColor];
//    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
//    self.navigationController.navigationBar.layer.shadowRadius = 3.0f;
//    self.navigationController.navigationBar.layer.shadowOpacity = 0.8f;
    
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_dataList release], _dataList = nil;
    [_dataTableView release], _dataTableView = nil;
    [super dealloc];
}

- (void)reloadTableView
{
    [self.dataTableView reloadData];
}

- (void)loadData
{
    [[BrandService defaultService] findBrandsWithDelegate:self];
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
    [_dataList addObjectsFromArray:objects];
    [_dataTableView reloadData];
}

#pragma mark -
#pragma mark TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BrandCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    Brand *brand = [_dataList objectAtIndex:indexPath.row];
	cell.textLabel.text = brand.name;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ItemViewController *controller = [[ItemViewController alloc] initWithBrand:[_dataList objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

@end
