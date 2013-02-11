//
//  ItemService.h
//  Letao
//
//  Created by Callon Tom on 13-2-2.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@protocol ItemServiceDelegate <NSObject>

@optional
- (void) didFindItems:(int)result itemList:(NSArray*)itemList;

@end

@interface ItemService : NSObject

+ (ItemService*)defalutService;

- (void)findItemsWithCategoryId:(int)categoryId start:(int)start count:(int)count delegate:(id<RKObjectLoaderDelegate>)delegate;

@end
