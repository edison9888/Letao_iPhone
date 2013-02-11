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

@property (retain, nonatomic) SlideImageView *slideImageView;
@property (retain, nonatomic) IBOutlet UIScrollView *dataScrollView;

//@property (retain, nonatomic) UILabel *titleLabel;
//@property (retain, nonatomic) UILabel *subtitleLabel;
//@property (retain, nonatomic) UILabel *descriptionLabel;
//@property (retain, nonatomic) UILabel *smooth_indexLabel;
//@property (retain, nonatomic) UILabel *informationLabel;
//@property (retain, nonatomic) UILabel *tipsLabel;

@property (assign, nonatomic) float totalHeight;




@property (retain, nonatomic)Item *item;

- (id)initWithItem:(Item*)item;
@end
