//
//  CommentViewController.h
//  Letao
//
//  Created by Kaibin on 13-3-18.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "Item.h"

@interface CommentViewController : UIViewController <UITextViewDelegate, RKRequestDelegate>

@property(nonatomic, retain) UITextView *textView;
@property(nonatomic, copy) NSString *item_id;

@end
