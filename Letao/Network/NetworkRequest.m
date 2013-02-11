//
//  NetworkRequest.m
//  Letao
//
//  Created by Callon Tom on 13-2-2.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "NetworkRequest.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import <RestKit/RestKit.h>

@implementation NetworkRequest

+ (NSDictionary*)sendRequest:(NSString*)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setAllowCompressedResponse:YES];
    [request startSynchronous];
    
    NSError *error = [request error];
    int statusCode = [request responseStatusCode];
    
    NSString *text = [request responseString];
    NSDictionary *jsonDictionary = nil; 
    if ([text length] > 0) {
        jsonDictionary = [text JSONValue];
    }
        
    return jsonDictionary;
}

@end
