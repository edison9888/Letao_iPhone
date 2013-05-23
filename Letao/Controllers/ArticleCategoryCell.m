//
//  ArticleCategoryCell.m
//  Letao
//
//  Created by Kaibin on 13-5-23.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "ArticleCategoryCell.h"
#import "ArticleCategory.h"

@implementation ArticleCategoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star-icon"]];
        [self.iconView setFrame:CGRectMake( 10.0f, 20.0f, 30.0f, 30.0f)];
        [self.contentView addSubview:self.iconView];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        
    }
    return self;
}

- (void)setCategory:(ArticleCategory *)category
{
    CGSize nameSize = [category.name sizeWithFont:[UIFont boldSystemFontOfSize:16.0f] forWidth:200.0f lineBreakMode:UILineBreakModeTailTruncation];
    [self.titleLabel setFrame:CGRectMake( 40.0f, 25.0f, 144.0f, nameSize.height)];
    NSString *title = [NSString stringWithFormat:@"  %@", category.name];
    self.titleLabel.text = title;
    self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetRGBFillColor(context, 0.05, 0.05, 0.15, 0.2);
	rect = CGRectMake(0, self.bounds.size.height - 2, self.bounds.size.width, 4);
	CGContextFillRect(context, rect);
}

+ (CGFloat)heightForCell
{
    return 67.0f;
}


@end
