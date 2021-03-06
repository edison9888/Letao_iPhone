//
//  BrandListViewController.h
//  Letao
//
//  Created by Kaibin on 13-2-13.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "BrandCell.h"

@interface BrandListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, RKObjectLoaderDelegate, BrandCellDelegate>

@property (nonatomic, retain)IBOutlet UITableView *dataTableView;
@property (nonatomic, retain) NSMutableArray *dataList;
@property (nonatomic, retain) NSMutableArray *demosticList;
@property (nonatomic, retain) NSMutableArray *foreignList;

@end
