//
//  Article.h
//  Letao
//
//  Created by Kaibin on 13-4-3.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *author;
@property(nonatomic, copy) NSString *date;
@property(nonatomic, copy) NSString *content;
@property (nonatomic, copy)NSString *_id;

@end
