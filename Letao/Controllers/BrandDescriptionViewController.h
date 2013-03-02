//
//  BrandDescriptionViewController.h
//  Letao
//
//  Created by Kaibin on 13-3-2.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Brand.h"

@interface BrandDescriptionViewController : UIViewController

@property (nonatomic, retain) UITextView *textView;
@property (nonatomic, retain) Brand *brand;

- (id)initWithBrand:(Brand*)brand;

@end
