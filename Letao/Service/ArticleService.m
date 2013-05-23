//
//  ArticleService.m
//  Letao
//
//  Created by Kaibin on 13-4-4.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "ArticleService.h"
#import "Article.h"
#import "ArticleCategory.h"
#import "StringUtil.h"

@implementation ArticleService

+(ArticleService*)sharedService
{
    static ArticleService *_sharedService = nil;
    @synchronized(self)
    {
        if (_sharedService == nil) {
            _sharedService = [[ArticleService alloc] init];
        }
    }
    return _sharedService;
}

- (id)init
{
    self = [super init];
    return self;
}

- (void)initObjectMap
{
    //获取在AppDelegate中生成的第一个RKObjectManager对象
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    RKObjectMapping *articleMapping =[RKObjectMapping mappingForClass:[Article class]];
    [articleMapping mapKeyPathsToAttributes: @"_id", @"_id", @"title", @"title", @"content", @"content", @"date", @"date", @"author", @"author", nil];
    [objectManager.mappingProvider setMapping:articleMapping forKeyPath:@""];
}

- (void)initCategoryMap
{
    //获取在AppDelegate中生成的第一个RKObjectManager对象
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    RKObjectMapping *articleMapping =[RKObjectMapping mappingForClass:[ArticleCategory class]];
    [articleMapping mapKeyPathsToAttributes: @"cat_id", @"_id", @"cat_name", @"name", nil];
    [objectManager.mappingProvider setMapping:articleMapping forKeyPath:@""];
}

- (void)findArticlesWithCategory:(NSString*)cat_id  start:(int)start count:(int)count delegate:(id<RKObjectLoaderDelegate>)delegate
{
    //映射所需类对象
    [self initObjectMap];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *startStr = [NSString stringWithInt:start];
        NSString *countStr = [NSString stringWithInt:count];
        NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:cat_id, @"cat_id", startStr, @"start", countStr, @"count",nil];
        RKObjectManager *objectManager = [RKObjectManager sharedManager];
        RKURL *url = [RKURL URLWithBaseURL:[objectManager baseURL] resourcePath:@"/articles" queryParameters:queryParams];
        
        NSLog(@"url: %@", [url absoluteString]);
        NSLog(@"resourcePath: %@", [url resourcePath]);
        NSLog(@"query: %@", [url query]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [objectManager loadObjectsAtResourcePath:[NSString stringWithFormat:@"%@?%@", [url resourcePath], [url query]] delegate:delegate ];
        });
    });
}

- (void)findArticleCategory:(id<RKObjectLoaderDelegate>)delegate
{
    //映射所需类对象
    [self initCategoryMap];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        NSDictionary *queryParams = nil;
        RKObjectManager *objectManager = [RKObjectManager sharedManager];
        RKURL *url = [RKURL URLWithBaseURL:[objectManager baseURL] resourcePath:@"/article_cat" queryParameters:queryParams];
        
        NSLog(@"url: %@", [url absoluteString]);
        NSLog(@"resourcePath: %@", [url resourcePath]);
        NSLog(@"query: %@", [url query]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [objectManager loadObjectsAtResourcePath:[NSString stringWithFormat:@"%@?%@", [url resourcePath], [url query]] delegate:delegate ];
        });
    });
}

@end
