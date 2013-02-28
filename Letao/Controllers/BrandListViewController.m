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
        _demosticList = [[NSMutableArray alloc] init];
        _foreignList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UISegmentedControl *toggle = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"国内",@"国外", nil]];
    toggle.segmentedControlStyle = UISegmentedControlStyleBar;
    toggle.selectedSegmentIndex = 0;
    CGRect frame = toggle.frame;
    frame.size.width = self.view.frame.size.width - 140;
    toggle.frame = frame;
    [toggle addTarget:self action:@selector(reloadTableView) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = toggle;
    [toggle release];
   
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
    [_demosticList release], _dataList = nil;
    [_foreignList release], _dataList = nil;
    [_dataTableView release], _dataTableView = nil;
    [super dealloc];
}

- (void)reloadTableView
{
    [self.dataTableView reloadData];
}

- (void)loadData
{
    [[BrandService sharedService] findBrandsWithDelegate:self];
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
    for (Brand *brand in _dataList) {
        if (brand.country_flag == 0) {
            [_demosticList addObject:brand];
        } else {
            [_foreignList addObject:brand];
        }
    }
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
    UISegmentedControl *toggle = (UISegmentedControl *)self.navigationItem.titleView;
    if (toggle.selectedSegmentIndex == 0) {
        return [_demosticList count];
    } else {
        return [_foreignList count];
    }
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
    
    UISegmentedControl *toggle = (UISegmentedControl *)self.navigationItem.titleView;
    Brand *brand = nil;
    if (toggle.selectedSegmentIndex == 0) {
        brand = [_demosticList objectAtIndex:indexPath.row];
    } else {
        brand = [_foreignList objectAtIndex:indexPath.row];
    }
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
