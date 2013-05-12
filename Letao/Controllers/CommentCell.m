//
//  CommentCell.m
//  Letao
//
//  Created by Kaibin on 13-3-15.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "CommentCell.h"
#import "LocaleUtils.h"

@implementation CommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 3.0f, 100.0f, 20.0f)];
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(220.0f, 3.0f, 100.0f, 20.0f)];
        self.contentLabel = [[UILabel alloc] init];
        
        [self.contentView addSubview:self.authorLabel];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.contentLabel];
    }
    return self;
}

NSString *dateFromISODateString(NSString *date)
{
    //    NSString *exampleDate = @"2013-03-19T08:55:53.2900008";
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormat setDateFormat:@"\"yyyy-MM-dd'T'HH:mm:ss.SSSSSSS\""];
    NSDate *tmpDate = [dateFormat dateFromString:date];
    [dateFormat setDateFormat:@"yyyy.MM.dd HH:mm"];
    NSString *dateString = [dateFormat stringFromDate:tmpDate];
    return dateString;
}

- (void)setComment:(Comment *)comment rowIndex:(int)rowIndex
{
    _comment = comment;
    self.authorLabel.text = [NSString stringWithFormat:@"%d%@",rowIndex+1,NSLS(@"kFloor")];//_comment.author;
    self.authorLabel.font = [UIFont systemFontOfSize:13];
    self.authorLabel.textColor = [UIColor darkGrayColor];
    self.authorLabel.backgroundColor = [UIColor clearColor];

    self.dateLabel.text = dateFromISODateString(_comment.date);
    self.dateLabel.font = [UIFont systemFontOfSize:12];
    self.dateLabel.textColor = [UIColor darkGrayColor];
    self.dateLabel.backgroundColor = [UIColor clearColor];
    
    CGSize withinSize = CGSizeMake(300, CGFLOAT_MAX);
    NSString *content = _comment.content;
    
    CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:withinSize lineBreakMode:UILineBreakModeWordWrap];
    [self.contentLabel setFrame:CGRectMake(10, 30, 300, size.height)];
    self.contentLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.backgroundColor = [UIColor clearColor];
    self.contentLabel.font = [UIFont systemFontOfSize:13];
    self.contentLabel.text = content;
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
