//
//  ItemService.m
//  Letao
//
//  Created by Kaibin on 13-2-2.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "ItemService.h"
#import "Item.h"
#import "StringUtil.h"
#import "GlobalConstants.h"

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
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    RKObjectMapping *itemMapping =[RKObjectMapping mappingForClass:[Item class]];
    [itemMapping mapKeyPathsToAttributes:@"title", @"title", @"subtitle", @"subtitle",      @"description", @"description", @"smooth_index", @"smooth_index", @"information", @"information", @"tips", @"tips", @"imageList", @"imageList", nil];
    [objectManager.mappingProvider setMapping:itemMapping forKeyPath:@""];        
}

- (void)findItemsWithBrandId:(int)brandId start:(int)start count:(int)count delegate:(id<RKObjectLoaderDelegate>)delegate
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *brand_id = [NSString stringWithInt:brandId];
        NSString *startStr = [NSString stringWithInt:start];
        NSString *countStr = [NSString stringWithInt:count];
        NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:brand_id, @"brand_id",startStr, @"start", countStr, @"count",nil];
        
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
