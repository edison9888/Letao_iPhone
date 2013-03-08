//
//  Item.m
//  Letao
//
//  Created by Kaibin on 13-2-4.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "Item.h"

@implementation Item

@synthesize title, subtitle, price, description, smooth_index, information, tips, imageList;

#pragma mark NSCoding delegate
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.subtitle forKey:@"subtitle"];
    [aCoder encodeObject:self.information forKey:@"information"];
    [aCoder encodeObject:self.description forKey:@"description"];
    [aCoder encodeObject:self.tips forKey:@"tips"];
    [aCoder encodeObject:self.smooth_index forKey:@"smooth_index"];
    [aCoder encodeObject:self.imageList forKey:@"imageList"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.subtitle = [aDecoder decodeObjectForKey:@"subtitle"];
        self.information = [aDecoder decodeObjectForKey:@"information"];
        self.description = [aDecoder decodeObjectForKey:@"description"];
        self.tips = [aDecoder decodeObjectForKey:@"tips"];
        self.smooth_index = [aDecoder decodeObjectForKey:@"smooth_index"];
        self.imageList = [aDecoder decodeObjectForKey:@"imageList"];
    }
    return self;
}
@end
