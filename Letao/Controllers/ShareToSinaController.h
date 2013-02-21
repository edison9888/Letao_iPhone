//
//  ShareToSinaController.h
//  Letao
//
//  Created by Kaibin on 13-2-20.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SinaweiboManager.h"
#import "PPViewController.h"

@class Item;

@interface ShareToSinaController : PPViewController<UITextViewDelegate, SinaWeiboDelegate, SinaWeiboRequestDelegate>
{
    SinaWeiboManager *_sinaweiboManager;
    Item *_item;
}

@property (nonatomic, retain) UITextView *contentTextView;
@property (nonatomic, retain) UILabel *wordsNumberLabel;

- (id)initWithItem:(Item*)item;

@end
