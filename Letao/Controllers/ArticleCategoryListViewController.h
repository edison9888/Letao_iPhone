//
//  ArticleCategoryListViewController.h
//  Letao
//
//  Created by Kaibin on 13-5-23.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "PPTableViewController.h"

@interface ArticleCategoryListViewController : PPTableViewController<RKObjectLoaderDelegate>

@property(nonatomic, copy)NSString *cat_id;

@end
