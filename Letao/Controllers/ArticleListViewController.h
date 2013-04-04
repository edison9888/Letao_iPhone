//
//  ArticleListViewController.h
//  Letao
//
//  Created by Kaibin on 13-4-3.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"


@interface ArticleListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, RKObjectLoaderDelegate, EGORefreshTableHeaderDelegate,EGORefreshTableFooterDelegate, UIScrollViewDelegate>
{
    BOOL _reloading;
    EGORefreshTableHeaderView *_refreshHeaderView;
    EGORefreshTableFooterView *_refreshFooterView;
    int _start;
    int totalCount;
    
    NSMutableArray *_dataList;
}

@property (nonatomic, retain)IBOutlet UITableView *dataTableView;
@property(nonatomic, assign) BOOL supportRefreshHeader;
@property(nonatomic, assign) BOOL supportRefreshFooter;

#pragma mark: For pull down to refresh
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

#pragma mark: For pull up to load more
- (void)loadMoreTableViewDataSource;
- (void)doneloadingMoreData;
@end
