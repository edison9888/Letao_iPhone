//
//  ItemDetailViewController.h
//  Letao
//
//  Created by Callon Tom on 13-2-6.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "Item.h"
#import "SlideImageView.h"

@interface ItemDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, RKObjectLoaderDelegate, UIActionSheetDelegate>

@property(retain, nonatomic) IBOutlet UIScrollView *dataScrollView;
@property(retain, nonatomic) IBOutlet UITableView *commentTableView;
@property(retain, nonatomic) UILabel *helpLabel;
@property(retain, nonatomic) UIButton *commentButton;
@property(assign, nonatomic) float totalHeight;
@property(retain, nonatomic) Item *item;
@property(retain, nonatomic) NSMutableArray *commentList;

- (id)initWithItem:(Item*)item;
@end
