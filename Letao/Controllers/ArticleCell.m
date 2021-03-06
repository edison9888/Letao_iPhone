//
//  ArticleCell.m
//  Letao
//
//  Created by Kaibin on 13-4-3.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "ArticleCell.h"
#import "Article.h"
#import "UIImage+Scale.h"

@implementation ArticleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        
        self.contentLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.contentLabel];               
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (highlighted) {
        UIImage *bg = [[UIImage imageNamed:@"cell_sel_bg"] scaleToSize:CGSizeMake(320, [ArticleCell heightForCell])];
        UIImageView *bgView = [[UIImageView alloc] initWithImage:bg];
        self.backgroundView = bgView;
        [bgView release];
    }
    else {
//        UIImage *bg = [[UIImage imageNamed:@"cell_bg"] scaleToSize:CGSizeMake(320, [ArticleCell heightForCell])];
//        UIImageView *bgView = [[UIImageView alloc] initWithImage:bg];
//        self.backgroundView = bgView;
//        [bgView release];
        self.backgroundView = nil;
    }
}

- (void)setArticle:(Article *)article
{
    CGSize nameSize = [article.title sizeWithFont:[UIFont boldSystemFontOfSize:15.0f] forWidth:200.0f lineBreakMode:UILineBreakModeTailTruncation];
    [self.titleLabel setFrame:CGRectMake( 5.0f, 5.0f, 300.0f, nameSize.height)];
//    NSString *title = [NSString stringWithFormat:@"【%@】%@",article.author,article.title];
    NSString *title = [NSString stringWithFormat:@"  %@", article.title];

    self.titleLabel.text = title;
    self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    self.titleLabel.backgroundColor = [UIColor clearColor];

    
    CGSize withinSize = CGSizeMake(300, 50);
    CGSize size = [article.content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:withinSize lineBreakMode:UILineBreakModeWordWrap];
    [self.contentLabel setFrame:CGRectMake(10, nameSize.height + 7, size.width, size.height)];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.backgroundColor = [UIColor clearColor];
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    self.contentLabel.text = article.content;
    self.contentLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.85];
    
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetRGBFillColor(context, 0.05, 0.05, 0.15, 0.2);
	rect = CGRectMake(0, self.bounds.size.height - 2, self.bounds.size.width, 4);
	CGContextFillRect(context, rect);
}

+ (CGFloat)heightForCell
{
    return 100.0f;
}

@end
