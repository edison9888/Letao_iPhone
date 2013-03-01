//
//  BrandCell.m
//  Letao
//
//  Created by Kaibin on 13-3-1.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "BrandCell.h"
#import "GlobalConstants.h"
#import "UIImageView+WebCache.h"

@implementation BrandCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.brandImageView = [[UIImageView alloc] init];
        [self.brandImageView setFrame:CGRectMake( 10.0f, 14.0f, 50.0f, 40.0f)];
        [self.contentView addSubview:self.brandImageView];
        
        self.nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.nameLabel];
    }
    return self;
}

- (void)setBrand:(Brand*)brand
{
    _brand = brand;
    NSString *imageUrl = _brand.image;
    if (![imageUrl hasPrefix:@"http"]) {
        imageUrl = [CONDOM_BRAND_IMAGE_URL_PREFIX stringByAppendingString:imageUrl];
    }
    [self.brandImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"photo-placeholder"]];
    
    CGSize nameSize = [_brand.name sizeWithFont:[UIFont boldSystemFontOfSize:16.0f] forWidth:144.0f lineBreakMode:UILineBreakModeTailTruncation];
    [self.nameLabel setFrame:CGRectMake( 70.0f, 25.0f, 144.0f, nameSize.height)];
    self.nameLabel.text = _brand.name;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)heightForCell
{
    return 67.0f;
}

@end
