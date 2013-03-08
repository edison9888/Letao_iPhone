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


- (void)dealloc
{
    [super dealloc];
}

+ (ItemService*)sharedService
{
    static ItemService *_sharedInstance = nil;
    @synchronized(self)
    {
        if (_sharedInstance == nil) {
            _sharedInstance = [[ItemService alloc] init];
        }
    }
        return _sharedInstance;
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
    RKObjectMapping *itemMapping =[RKObjectMapping mappingForClass:[Item class]];
    [itemMapping mapKeyPathsToAttributes:@"title", @"title", @"subtitle", @"subtitle",      @"description", @"description", @"smooth_index", @"smooth_index", @"information", @"information", @"tips", @"tips", @"imageList", @"imageList", @"price", @"price", nil];
    [objectManager.mappingProvider setMapping:itemMapping forKeyPath:@""];        
}

- (void)findItemsWithBrandId:(NSString*)brandId start:(int)start count:(int)count delegate:(id<RKObjectLoaderDelegate>)delegate
{
    //映射所需类对象
    [self initObjectMap];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *startStr = [NSString stringWithInt:start];
        NSString *countStr = [NSString stringWithInt:count];
        NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:brandId, @"brand_id",startStr, @"start", countStr, @"count",nil];
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
