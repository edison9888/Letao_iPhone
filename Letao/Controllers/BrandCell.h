//
//  BrandCell.h
//  Letao
//
//  Created by Kaibin on 13-3-1.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Brand.h"

@protocol BrandCellDelegate;

@interface BrandCell : UITableViewCell

@property (nonatomic, strong) id<BrandCellDelegate> delegate;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *brandImageView;
@property (nonatomic, strong) UIButton *brandImageButton;
@property (nonatomic, strong) Brand *brand;

- (void)setBrand:(Brand*)brand;
+ (CGFloat)heightForCell;
- (void)didTapImageButtonAction:(id)sender;

@end

@protocol BrandCellDelegate <NSObject>
@optional

- (void)cell:(BrandCell*)cellView didTapImageButton:(Brand*)brand;

@end
