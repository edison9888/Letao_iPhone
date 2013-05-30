//
//  FavouriteViewController.h
//  Letao
//
//  Created by Kaibin on 13-2-17.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMGridView.h"
#import "PPViewController.h"

@interface FavouriteViewController : PPViewController<GMGridViewDataSource, GMGridViewSortingDelegate, GMGridViewActionDelegate, GMGridViewTransformationDelegate>
{
    GMGridView *_gmGridView;
}

@property(nonatomic, retain) NSMutableArray *data;
@property(nonatomic, assign) NSInteger lastDeleteItemIndexAsked;
@property (nonatomic, retain) UILabel *helpLabel;
@property (nonatomic, retain) UIView *adView;

@end
