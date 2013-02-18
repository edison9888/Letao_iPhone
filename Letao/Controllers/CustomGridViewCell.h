//
//  CustomGridViewCell.h
//  GMGridViewExample
//
//  Created by Callon Tom on 13-1-30.
//  Copyright (c) 2013年 GMoledina.ca. All rights reserved.
//

#import "GMGridViewCell.h"
#import "GMGridViewCell+Extended.h"

@interface CustomGridViewCell : GMGridViewCell

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIView *textLabelBackgroundView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIImageView *imageView;
@end
