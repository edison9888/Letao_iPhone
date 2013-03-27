//
//  ItemViewController.h
//  Letao
//
//  Created by Kaibin on 13-1-31.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GMGridView/GMGridView.h>
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"
#import <RestKit/RestKit.h>
#import "Brand.h"

@interface ItemViewController : UIViewController <EGORefreshTableHeaderDelegate,EGORefreshTableFooterDelegate, UIScrollViewDelegate, GMGridViewDataSource, GMGridViewTransformationDelegate, GMGridViewActionDelegate, RKObjectLoaderDelegate>
{
    BOOL _reloading;
    EGORefreshTableHeaderView *_refreshHeaderView;
    EGORefreshTableFooterView *_refreshFooterView;
    GMGridView *_gmGridView;
    
    NSMutableArray *_data;
    NSMutableArray *_currentData;
    Brand *_brand;
    
    int _start;
    int totalCount;
    
}

@property(nonatomic, assign) NSInteger lastDeleteItemIndexAsked;

@property(nonatomic, assign) BOOL supportRefreshHeader;
@property(nonatomic, assign) BOOL supportRefreshFooter;

- (id)initWithBrand:(Brand*)brand;
- (id)initWithData:(NSArray*)array;

#pragma mark: For pull down to refresh
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

#pragma mark: For pull up to load more
- (void)loadMoreTableViewDataSource;
- (void)doneloadingMoreData;
@end
