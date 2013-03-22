//
//  CommentCell.h
//  Letao
//
//  Created by Kaibin on 13-3-15.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"

@interface CommentCell : UITableViewCell

@property(nonatomic, strong)UILabel *authorLabel;
@property(nonatomic, strong)UILabel *dateLabel;
@property(nonatomic, strong)UILabel *contentLabel;
@property (nonatomic, strong) Comment *comment;

- (void)setComment:(Comment *)comment;
+ (CGFloat)heightForCell;
@end
