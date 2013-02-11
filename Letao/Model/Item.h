//
//  Item.h
//  Letao
//
//  Created by Callon Tom on 13-2-4.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (nonatomic, copy)NSString *_id;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *subtitle;
@property (nonatomic, copy)NSString *description;
@property (nonatomic, copy)NSString *smooth_index;
@property (nonatomic, copy)NSString *information;
@property (nonatomic, copy)NSString *tips;
@property (nonatomic, retain)NSArray *imageList;

@end
