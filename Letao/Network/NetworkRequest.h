//
//  NetworkRequest.h
//  Letao
//
//  Created by Callon Tom on 13-2-2.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkRequest : NSObject

+ (NSDictionary*)sendRequest:(NSString*)url;

@end
