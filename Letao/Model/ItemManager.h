//
//  ItemManager.h
//  Letao
//
//  Created by Kaibin on 13-2-16.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface ItemManager : NSObject

+ (ItemManager*)defaultManager;

- (void)addItemIntoFavourite:(Item*)item;
- (void)removeItemFromFavourite:(Item*)item;
- (NSArray*)loadFavouriteItems;

@end
