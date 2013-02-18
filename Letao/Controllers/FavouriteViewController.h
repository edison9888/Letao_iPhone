//
//  FavouriteViewController.h
//  Letao
//
//  Created by Kaibin on 13-2-17.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GMGridView/GMGridView.h>


@interface FavouriteViewController : UIViewController<GMGridViewDataSource, GMGridViewSortingDelegate, GMGridViewActionDelegate, GMGridViewTransformationDelegate>
{
    GMGridView *_gmGridView;
}

@property(nonatomic, retain) NSMutableArray *data;
@property(nonatomic, assign) NSInteger lastDeleteItemIndexAsked;

@end
