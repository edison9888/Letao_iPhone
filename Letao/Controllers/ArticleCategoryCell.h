//
//  ArticleCategoryCell.h
//  Letao
//
//  Created by Kaibin on 13-5-23.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleCategoryCell.h"
#import "ArticleCategory.h"

@interface ArticleCategoryCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconView;

- (void)setCategory:(ArticleCategory *)category;
+ (CGFloat)heightForCell;

@end
