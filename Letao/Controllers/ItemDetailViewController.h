//
//  ItemDetailViewController.h
//  Letao
//
//  Created by Callon Tom on 13-2-6.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
#import "SlideImageView.h"

@interface ItemDetailViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIScrollView *dataScrollView;
@property (assign, nonatomic) float totalHeight;
@property (retain, nonatomic) Item *item;

- (id)initWithItem:(Item*)item;
@end
