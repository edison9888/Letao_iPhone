//
//  ItemService.h
//  Letao
//
//  Created by Kaibin on 13-2-2.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface ItemService : NSObject

+ (ItemService*)sharedService;

- (void)findItemsWithBrandId:(NSString*)brand_id start:(int)start count:(int)count delegate:(id<RKObjectLoaderDelegate>)delegate;

- (void)search:(NSString*)keyword delegate:(id<RKObjectLoaderDelegate>)delegate;

@end
