//
//  CustomGridViewCell.m
//  GMGridViewExample
//
//  Created by Callon Tom on 13-1-30.
//  Copyright (c) 2013年 GMoledina.ca. All rights reserved.
//

#import "CustomGridViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation CustomGridViewCell

//- (id)initWithFrame:(CGRect)frame
- (id)init
{
    if ((self = [super init])) {
        // Background view        
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectNull];
//        self.backgroundView.backgroundColor = [UIColor colorWithRed:65/255.0 green:105/255.0 blue:225/255.0 alpha:1.0];
        self.backgroundView.layer.borderWidth = 1;
        self.backgroundView.layer.borderColor = [UIColor purpleColor].CGColor;
        [self addSubview:self.backgroundView];
        
        // Image view
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectNull];
        [self addSubview:self.imageView];
        
        // Label
        self.textLabelBackgroundView = [[UIView alloc] initWithFrame:CGRectNull];
        self.textLabelBackgroundView.backgroundColor = [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:0.4];
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectNull];
        self.textLabel.textAlignment = NSTextAlignmentRight;
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.font = [UIFont systemFontOfSize:12];
        
        [self.textLabelBackgroundView addSubview:self.textLabel];
        [self addSubview:self.textLabelBackgroundView];
    }
    [self bringSubviewToFront:self.deleteButton];
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int labelHeight = 20;
    int inset = 5;
    
    // Background view
    self.backgroundView.frame = self.bounds;
    self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    self.clipsToBounds = YES;
    
    // Image view
    CGRect bg = CGRectMake(self.bounds.origin.x+1, self.bounds.origin.y+1, self.bounds.size.width-2, self.bounds.size.height-2);
    self.imageView.frame = bg;
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    self.imageView.clipsToBounds = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    // Layout label
    self.textLabelBackgroundView.frame = CGRectMake(0,
                                                    self.bounds.size.height - labelHeight,
                                                    self.bounds.size.width,
                                                    labelHeight);
    self.textLabelBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // Layout label background
    CGRect f = CGRectMake(0,
                          0,
                          self.textLabel.superview.bounds.size.width,
                          self.textLabel.superview.bounds.size.height);
    self.textLabel.frame = CGRectInset(f, inset, 0);
    self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

@end
