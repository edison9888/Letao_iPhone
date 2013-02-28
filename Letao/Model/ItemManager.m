//
//  ItemManager.m
//  Letao
//
//  Created by Kaibin on 13-2-16.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "ItemManager.h"
#import "FileUtil.h"

@implementation ItemManager


+ (ItemManager*)sharedManager
{
    static ItemManager *_sharedManager;
    @synchronized(self)
    {
        if (_sharedManager == nil) {
            _sharedManager = [[super alloc] init];
        }
    }
    return _sharedManager;
}

- (NSString*)getFilePath
{
    return [[FileUtil getAppHomeDir] stringByAppendingPathComponent:@"items.dat"];
}

- (NSArray*)loadFavouriteItems
{
    NSMutableArray *itemArray = [[[NSMutableArray alloc] init] autorelease];
    NSArray *array = [NSArray arrayWithContentsOfFile:[self getFilePath]];
    NSLog(@"load item from file count: %d",array.count);
    if ([array count] > 0) {
        for (NSData *aData in array) {
            Item *item = [NSKeyedUnarchiver unarchiveObjectWithData:aData];
            [itemArray addObject:item];
        }
    }
    return itemArray;
}

- (void)writeToFileWithArray:(NSArray*)array
{
    NSMutableArray *dataArray = [[[NSMutableArray alloc] init] autorelease];
    for (Item *item in array) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:item];
        [dataArray addObject:data];
    }
    
    if (![dataArray writeToFile:[self getFilePath] atomically:YES]) {
        NSLog(@"<writeToFileWithArray> wirteToFile error");
    }
    NSLog(@"write to file count: %d",dataArray.count);
}

- (void)addItemIntoFavourite:(Item*)item
{
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:[self loadFavouriteItems]];
    [newArray addObject:item];
    [self writeToFileWithArray:newArray];
}

//you are not allowed to change arrays when you are enumerating them.
- (void)removeItemFromFavourite:(Item*)item
{
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:[self loadFavouriteItems]];
    NSMutableArray *itemToDelete = [NSMutableArray array];
    for (Item *aItem in newArray) {
        if ([aItem.title isEqualToString:item.title]) {
            [itemToDelete addObject:aItem];
            break;
        }
    }
    [newArray removeObjectsInArray:itemToDelete];
    [self writeToFileWithArray:newArray];
}

@end
