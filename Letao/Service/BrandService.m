//
//  BrandService.m
//  Letao
//
//  Created by Callon Tom on 13-2-13.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "BrandService.h"
#import "GlobalConstants.h"
#import "Brand.h"
#import "StringUtil.h"
#import "Item.h"

@implementation BrandService

static BrandService *_defaultBrandService = nil;

+ (BrandService*)defaultService
{
    if (_defaultBrandService == nil) {
        _defaultBrandService = [[BrandService alloc] init];
    }
    return _defaultBrandService;
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
    RKObjectMapping *brandMapping =[RKObjectMapping mappingForClass:[Brand class]];
    [brandMapping mapKeyPathsToAttributes:@"name", @"name", @"brand_id", @"brand_id", nil];
    [objectManager.mappingProvider setMapping:brandMapping forKeyPath:@""];    
}


- (void)findBrandsWithDelegate:(id<RKObjectLoaderDelegate>)delegate
{
     //映射所需类对象
    [self initObjectMap];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        RKObjectManager *objectManager = [RKObjectManager sharedManager];
        RKURL *url = [RKURL URLWithBaseURL:[objectManager baseURL] resourcePath:@"/brands" queryParameters:nil];
        
        NSLog(@"url: %@", [url absoluteString]);
        NSLog(@"resourcePath: %@", [url resourcePath]);
        NSLog(@"query: %@", [url query]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [objectManager loadObjectsAtResourcePath:[NSString stringWithFormat:@"%@?%@", [url resourcePath], [url query]] delegate:delegate ];
        });
    });
}

@end
