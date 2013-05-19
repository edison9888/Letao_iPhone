//
//  MoreCommentListViewController.h
//  Letao
//
//  Created by Kaibin on 13-5-18.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "PPTableViewController.h"

@interface MoreCommentListViewController : PPTableViewController<RKObjectLoaderDelegate>

@property (nonatomic, copy) NSString *itemid;

@end
