//
//  NSDictionary+XDHDictionary.m
//  XDHTool
//
//  Created by xudehuai on 2017/6/16.
//  Copyright © 2017年 com.xudehuai. All rights reserved.
//

#import "NSDictionary+XDHDictionary.h"

@implementation NSDictionary (XDHDictionary)

- (BOOL)xdh_isEmpty {
    
    if (self == nil || self.count == 0) {
        return YES;
    }
    return NO;
}

@end
