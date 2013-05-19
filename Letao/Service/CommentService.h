//
//  CommentService.h
//  Letao
//
//  Created by Kaibin on 13-3-18.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "Comment.h"

@interface CommentService : NSObject

+ (CommentService*)sharedService;

- (void)postComment:(Comment*)comment delegate:(id<RKRequestDelegate>)delegate;
- (void)findCommentsWithItemId:(NSString*)item_id delegate:(id<RKObjectLoaderDelegate>)delegate;
- (void)findCommentsWithItemId:(NSString*)item_id start:(int)start count:(int)count delegate:(id<RKObjectLoaderDelegate>)delegate;

@end
