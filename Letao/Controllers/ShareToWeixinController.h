//
//  ShareToWeixinControllerViewController.h
//  Letao
//
//  Created by Kaibin on 13-4-14.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface ShareToWeixinController : UIViewController<UITextViewDelegate>
{
    Item *_item;
}

@property (nonatomic, retain) UITextView *contentTextView;
@property (nonatomic, retain) UILabel *wordsNumberLabel;
@property (nonatomic, assign) int scene;

- (id)initWithItem:(Item*)item;

@end
