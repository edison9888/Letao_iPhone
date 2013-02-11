//
//  ItemService.m
//  Letao
//
//  Created by Callon Tom on 13-2-2.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "ItemService.h"
#import "Item.h"
#import "StringUtil.h"

#define kBaseURL @"http://127.0.0.1:5000"

@implementation ItemService

static ItemService *_defaultItemService = nil;

- (void)dealloc
{
    [super dealloc];
}

+ (ItemService*)defalutService
{
    if (_defaultItemService == nil) {
        _defaultItemService = [[ItemService alloc] init];
    }
    return _defaultItemService;
}

- (id)init
{
    self = [super init];
    [self initObjectMap];
    return self;
}

- (void)initObjectMap
{
    RKURL *baseURL = [RKURL URLWithBaseURLString:kBaseURL];
    RKObjectManager *objectManager = [RKObjectManager objectManagerWithBaseURL:baseURL];
    objectManager.client.baseURL = baseURL;

    RKObjectMapping *itemMapping =[RKObjectMapping mappingForClass:[Item class]];
    [itemMapping mapKeyPathsToAttributes:@"_id" ,@"_id", @"title", @"title", @"subtitle", @"subtitle",
                                    @"description", @"description", @"smooth_index", @"smooth_index",
                                    @"information", @"information", @"tips", @"tips", @"imageList", @"imageList", nil];
    [objectManager.mappingProvider setMapping:itemMapping forKeyPath:@""];

        
}

- (void)findItemsWithCategoryId:(int)categoryId start:(int)start count:(int)count delegate:(id<RKObjectLoaderDelegate>)delegate
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
                
        NSString *category_id = [NSString stringWithInt:categoryId];
        NSString *startStr = [NSString stringWithInt:start];
        NSString *countStr = [NSString stringWithInt:count];
        NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:category_id, @"category_id",startStr, @"start", countStr, @"count",nil];
        RKObjectManager *objectManager = [RKObjectManager sharedManager];
        RKURL *url = [RKURL URLWithBaseURL:[objectManager baseURL] resourcePath:@"/items" queryParameters:queryParams];
        
        NSLog(@"url: %@", [url absoluteString]);
        NSLog(@"resourcePath: %@", [url resourcePath]);
        NSLog(@"query: %@", [url query]);
                
        dispatch_async(dispatch_get_main_queue(), ^{
            [objectManager loadObjectsAtResourcePath:[NSString stringWithFormat:@"%@?%@", [url resourcePath], [url query]] delegate:delegate ];
        });
    });
}

@end
