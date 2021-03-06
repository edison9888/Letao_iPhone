//
//  ArticleService.h
//  Letao
//
//  Created by Kaibin on 13-4-4.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface ArticleService : NSObject

+(ArticleService*)sharedService;

- (void)findArticlesWithCategory:(NSString*)cat_id  start:(int)start count:(int)count delegate:(id<RKObjectLoaderDelegate>)delegate;

- (void)findArticleCategory:(id<RKObjectLoaderDelegate>)delegate;

@end
