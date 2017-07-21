//
//  NSString+XDHString.h
//  XDHTool
//
//  Created by xudehuai on 2017/6/16.
//  Copyright © 2017年 com.xudehuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (XDHString)

#pragma mark

// MD5加密
- (NSString *)xdh_md5String;

// 获取文本尺寸
- (CGSize)xdh_getSizeWithSize:(CGSize)size fontSize:(NSInteger)fontSize;

#pragma mark - 验证

// 纯数字
- (BOOL)xdh_isPureNumberWithMin:(NSUInteger) min Max:(NSUInteger) max;

// 纯字母-大小写
- (BOOL)xdh_isPureLetterWithMin:(NSUInteger) min Max:(NSUInteger) max;

// 纯字母-大写
- (BOOL)xdh_isPureUpperLetterWithMin:(NSUInteger) min Max:(NSUInteger) max;

// 纯字母-小写
- (BOOL)xdh_isPureLowerLetterWithMin:(NSUInteger) min Max:(NSUInteger) max;

// 电话号码-带区号
- (BOOL)xdh_isPhoneNumber;

// 手机号码
- (BOOL)xdh_isMobilePhoneNumber;

@end
