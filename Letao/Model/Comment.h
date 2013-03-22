//
//  Comment.h
//  Letao
//
//  Created by Kaibin on 13-3-15.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

@property(nonatomic, copy)NSString *author;
@property(nonatomic, copy)NSString *date;
@property(nonatomic, copy)NSString *content;
@property(nonatomic, copy)NSString *item_id;

@end
