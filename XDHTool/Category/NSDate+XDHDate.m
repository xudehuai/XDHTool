//
//  NSDate+XDHDate.m
//  XDHTool
//
//  Created by xudehuai on 2017/6/16.
//  Copyright © 2017年 com.xudehuai. All rights reserved.
//

#import "NSDate+XDHDate.h"

@implementation NSDate (XDHDate)

- (NSString *)xdh_dateStringWithFormatter:(NSString *)formatterString {
    
    if (formatterString) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = formatterString;
        NSString *dateString = [dateFormatter stringFromDate:self];
        
        return dateString;
    }
    return @"";
}

@end
