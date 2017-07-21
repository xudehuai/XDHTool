//
//  NSString+XDHString.m
//  XDHTool
//
//  Created by xudehuai on 2017/6/16.
//  Copyright © 2017年 com.xudehuai. All rights reserved.
//

#import "NSString+XDHString.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (XDHString)

- (NSString *)xdh_md5String {
    
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (CGSize)xdh_getSizeWithSize:(CGSize)size fontSize:(NSInteger)fontSize {
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize retSize = [self boundingRectWithSize:size
                                        options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    return retSize;
}

- (BOOL)xdh_isPureNumberWithMin:(NSUInteger)min Max:(NSUInteger)max {
    
    NSString *condition;
    
    // min位纯数字
    if (min == max) {
        condition = @"^[0-9]{min}$";
    }
    // min-max位纯数字
    else {
        condition = [NSString stringWithFormat:@"^[0-9]{%tu, %tu}$", min, max];
    }
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", condition];
    
    return [pre evaluateWithObject:self];
}

- (BOOL)xdh_isPureLetterWithMin:(NSUInteger)min Max:(NSUInteger)max {
    
    NSString *condition;
    
    if (min == max) {
        condition = @"^[a-zA-Z]{min}$";
    }
    else {
        condition = [NSString stringWithFormat:@"^[a-zA-Z]{%tu, %tu}$", min, max];
    }
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", condition];
    
    return [pre evaluateWithObject:self];
}

- (BOOL)xdh_isPureUpperLetterWithMin:(NSUInteger)min Max:(NSUInteger)max {
    
    NSString *condition;
    
    if (min == max) {
        condition = @"^[A-Z]{min}$";
    }
    else {
        condition = [NSString stringWithFormat:@"^[A-Z]{%tu, %tu}$", min, max];
    }
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", condition];
    
    return [pre evaluateWithObject:self];
}

- (BOOL)xdh_isPureLowerLetterWithMin:(NSUInteger)min Max:(NSUInteger)max {
    
    NSString *condition;
    
    if (min == max) {
        condition = @"^[a-z]{min}$";
    }
    else {
        condition = [NSString stringWithFormat:@"^[a-z]{%tu, %tu}$", min, max];
    }
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", condition];
    
    return [pre evaluateWithObject:self];
}

- (BOOL)xdh_isPhoneNumber {
    
    NSString *condition = @"^([\\d{3,4}-)\\d{7,8}$](file:///d%7B3,4%7D-)//d%7B7,8%7D$)";
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", condition];
    
    return [pre evaluateWithObject:self];
}

- (BOOL)xdh_isMobilePhoneNumber {
    
    NSString *condition = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", condition];
    
    return [pre evaluateWithObject:self];
}

@end
