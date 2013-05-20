//
//  ArticleListViewController.m
//  Letao
//
//  Created by Kaibin on 13-4-3.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "ArticleListViewController.h"
#import "ArticleCell.h"
#import "Article.h"
#import "ArticleDetailViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "ArticleService.h"
#import "UIImage+Scale.h"
#import "AdService.h"

#define COUNT_EACH_FETCH 10

@implementation ArticleListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _start = 0;
    [self loadDataFrom:_start count:COUNT_EACH_FETCH];
    
    _supportRefreshHeader = YES;
    _supportRefreshFooter = YES;
    
    if (_supportRefreshHeader && _refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - _dataTableView.bounds.size.height, self.view.frame.size.width, _dataTableView.bounds.size.height)];
		view.delegate = self;
		[_dataTableView addSubview:view];
		_refreshHeaderView = view;
		[view release];
		
	}
    [_refreshHeaderView refreshLastUpdatedDate];
    
    if (_supportRefreshFooter && _refreshFooterView == nil) {
        EGORefreshTableFooterView *view = [[EGORefreshTableFooterView alloc] initWithFrame: CGRectMake(0.0f, COUNT_EACH_FETCH * [ArticleCell heightForCell], _dataTableView.frame.size.width, _dataTableView.frame.size.height)];
		view.delegate = self;
		[_dataTableView addSubview:view];
        _refreshFooterView = view;
        [view release];
    }
    [_refreshFooterView refreshLastUpdatedDate];

}

- (void)viewDidUnload
{
    _dataTableView = nil;
    _refreshHeaderView = nil;
    _refreshFooterView = nil;
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    self.adView = [[AdService sharedService] createAdInView:self
//                                                      frame:CGRectMake(0, self.view.bounds.size.height-AD_BANNER_HEIGHT, AD_BANNER_WIDTH, AD_BANNER_HEIGHT)];
//    
//    [super viewDidAppear:animated];
//}
//
//- (void)viewDidDisappear:(BOOL)animated
//{
//    [[AdService sharedService] removeAdView:self.adView];
//    self.adView = nil;
//    [super viewDidDisappear:animated];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_dataTableView release], _dataTableView = nil;
    [_adView release], _adView = nil;
    [super dealloc];
}

- (void)loadDataFrom:(int)start count:(int)count
{
    NSLog(@"Load data from remote server");
    [[ArticleService sharedService] findArticlesWithStart:_start count:COUNT_EACH_FETCH delegate:self];
    _supportRefreshHeader = YES;
    _supportRefreshFooter = YES;
}

#pragma mark -
#pragma mark TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ArticleCell heightForCell];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ArticleCell";
    
    ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[ArticleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    Article *article = [_dataList objectAtIndex:indexPath.row];
    [cell setArticle:article];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImage *bg = [[UIImage imageNamed:@"cell_bg"] scaleToSize:CGSizeMake(320, [ArticleCell heightForCell])];
    UIImageView *bgView = [[UIImageView alloc] initWithImage:bg];
    cell.backgroundView = bgView;
    [bgView release];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Article *article = [_dataList objectAtIndex:indexPath.row];
    ArticleDetailViewController *controller = [[ArticleDetailViewController alloc] initWithArticle:article];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    HUD.labelText = @"正在加载中...";
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    NSLog(@"***Load objects start offset: %d", _start);
    if (_start == 0) {
        [_dataList release];
        _dataList = [[NSMutableArray alloc] init];
    }
    _start += [objects count];
    [_dataList addObjectsFromArray:objects];
    [_dataTableView reloadData];
    NSLog(@"***Load objects count: %d", [objects count]);
    NSLog(@"***Total objects count: %d", [_dataList count]);
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_supportRefreshHeader) {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
        
    }
    if (_supportRefreshFooter) {
        [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	if (_supportRefreshHeader) {
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
    if (_supportRefreshFooter) {
        [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
    }
	
}
#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource
{
//    [_dataList removeAllObjects];
    _start = 0;
    [self loadDataFrom:_start count:COUNT_EACH_FETCH];
}

- (void)doneLoadingTableViewData
{
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_dataTableView];
}

- (void)loadMoreTableViewDataSource
{
    [self loadDataFrom:_start count:COUNT_EACH_FETCH];
}

- (void)doneloadingMoreData
{
    _reloading = NO;
    [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:_dataTableView];
    
    //reset the _refreshFooterView frame
    _refreshFooterView.frame = CGRectMake(0.0f, _dataTableView.contentSize.height, _dataTableView.frame.size.width, _dataTableView.frame.size.height);
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    
    _reloading = YES;
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:2.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
	
	return [NSDate date]; // should return date data source was last changed
	
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableFooterDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    _reloading = YES;
	[self loadMoreTableViewDataSource];
    [self performSelector:@selector(doneloadingMoreData) withObject:nil afterDelay:2.0];
}

- (BOOL)egoRefreshTableFooterDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
    
    return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableFooterDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
    
	return [NSDate date]; // should return date data source was last changed
}

@end
