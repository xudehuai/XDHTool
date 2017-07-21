//
//  NSArray+XDHArray.m
//  XDHTool
//
//  Created by xudehuai on 2017/6/16.
//  Copyright © 2017年 com.xudehuai. All rights reserved.
//

#import "NSArray+XDHArray.h"

@implementation NSArray (XDHArray)

- (BOOL)xdh_isEmpty {
    
    if (self == nil || self.count == 0) {
        return YES;
    }
    return NO;
}

- (NSArray *)xdh_deduplication {
    
    return [self valueForKeyPath:@"@distinctUnionOfObjects.self"];
}

@end
