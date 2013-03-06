//
//  Brand.h
//  Letao
//
//  Created by Callon Tom on 13-2-13.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Brand : NSObject

@property(nonatomic, assign) NSInteger brand_id;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *image;
@property(nonatomic, assign) NSInteger country_flag;
@property(nonatomic, copy) NSString *introduction;
@property(nonatomic, assign) NSInteger totalNumber;

@end
