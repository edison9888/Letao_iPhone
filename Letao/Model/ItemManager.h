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

+ (ItemManager*)sharedManager;

- (BOOL)existItemInFavourites:(Item*)item;
- (void)addItemIntoFavourites:(Item*)item;
- (void)removeItemFromFavourites:(Item*)item;
- (NSArray*)loadFavourites;

@end
