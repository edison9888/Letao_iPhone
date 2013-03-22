//
//  CommentService.m
//  Letao
//
//  Created by Kaibin on 13-3-18.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "CommentService.h"

@implementation CommentService

- (id)init
{
    self = [super init];
    return self;
}

+ (CommentService*)sharedService
{
    static CommentService *_sharedInstance = nil;
    @synchronized(self)
    {
        if (_sharedInstance == nil) {
            _sharedInstance = [[CommentService alloc] init];
        }
    }
    return _sharedInstance;

}

- (void)postComment:(Comment*)comment delegate:(id<RKRequestDelegate>)delegate
{
//    RKParams *params = [RKParams params];
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    NSLog(@"*****author: %@",comment.author);
    NSLog(@"*****content: %@",comment.content);
    NSLog(@"*****item_id: %@",comment.item_id);
    [params setValue:comment.author forKey:@"author"];
    [params setValue:comment.content forKey:@"content"];
    [params setValue:comment.item_id forKey:@"item_id"];
    [[RKClient sharedClient] post:@"/addComment" params:params delegate:delegate];
}

- (void)initObjectMap
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    RKObjectMapping *commentMapping =[RKObjectMapping mappingForClass:[Comment class]];
    [commentMapping mapKeyPathsToAttributes:@"author", @"author", @"item_id", @"item_id", @"content", @"content", @"date", @"date", nil];
    [objectManager.mappingProvider setMapping:commentMapping forKeyPath:@""];
}

- (void)findCommentsWithItemId:(NSString*)item_id delegate:(id<RKObjectLoaderDelegate>)delegate
{
    [self initObjectMap];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:item_id, @"item_id", nil];
        RKObjectManager *objectManager = [RKObjectManager sharedManager];
        RKURL *url = [RKURL URLWithBaseURL:[objectManager baseURL] resourcePath:@"/comments" queryParameters:queryParams];
        
        NSLog(@"url: %@", [url absoluteString]);
        NSLog(@"resourcePath: %@", [url resourcePath]);
        NSLog(@"query: %@", [url query]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [objectManager loadObjectsAtResourcePath:[NSString stringWithFormat:@"%@?%@", [url resourcePath], [url query]] delegate:delegate ];
        });
    });

}

@end
