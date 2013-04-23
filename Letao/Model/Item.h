//
//  Item.h
//  Letao
//
//  Created by Kaibin on 13-2-4.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject<NSCoding>

@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *subtitle;
@property (nonatomic, copy)NSString *buy_url;
@property (nonatomic, copy)NSString *description;
@property (nonatomic, copy)NSString *price;
@property (nonatomic, copy)NSString *smooth_index;
@property (nonatomic, copy)NSString *information;
@property (nonatomic, copy)NSString *tips;
@property (nonatomic, retain)NSArray *imageList;
@property (nonatomic, retain)NSArray *commentList;
@property (nonatomic, copy)NSString *_id;

@end
