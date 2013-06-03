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
#import <MessageUI/MessageUI.h>
#import "AWActionSheet.h"
#import "PPViewController.h"

@interface ItemDetailViewController : PPViewController<UITableViewDataSource, UITableViewDelegate, RKObjectLoaderDelegate, UIActionSheetDelegate, AWActionSheetDelegate, MFMailComposeViewControllerDelegate, UIWebViewDelegate>

@property(retain, nonatomic) IBOutlet UIScrollView *dataScrollView;
@property(retain, nonatomic) IBOutlet UITableView *commentTableView;
@property(retain, nonatomic) UILabel *helpLabel;
@property(assign, nonatomic) float totalHeight;
@property(retain, nonatomic) Item *item;
@property(retain, nonatomic) NSMutableArray *commentList;
@property(retain, nonatomic) UIButton *shareButton;
@property(retain, nonatomic) UIButton *buyButton;
@property(retain, nonatomic) UIButton *moreButton;
@property(retain, nonatomic) UILabel *commentLabel;

- (id)initWithItem:(Item*)item;
@end
