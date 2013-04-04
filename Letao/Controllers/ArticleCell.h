//
//  ArticleCell.h
//  Letao
//
//  Created by Kaibin on 13-4-3.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Article;

@interface ArticleCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

- (void)setArticle:(Article*)article;
+ (CGFloat)heightForCell;

@end