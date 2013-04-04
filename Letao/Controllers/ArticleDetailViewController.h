//
//  ArticleDetailViewController.h
//  Letao
//
//  Created by Kaibin on 13-4-4.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@interface ArticleDetailViewController : UIViewController

@property (nonatomic, retain) Article *article;
@property(retain, nonatomic) IBOutlet UIScrollView *dataScrollView;
@property(assign, nonatomic) float totalHeight;

- (id)initWithArticle:(Article*)article;

@end
