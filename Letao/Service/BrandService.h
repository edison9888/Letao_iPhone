//
//  BrandService.h
//  Letao
//
//  Created by Callon Tom on 13-2-13.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>


@interface BrandService : NSObject

+ (BrandService*)sharedService;

- (void)findBrandsWithDelegate:(id<RKObjectLoaderDelegate>)delegate;

@end
