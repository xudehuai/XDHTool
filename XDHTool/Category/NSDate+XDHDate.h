//
//  NSDate+XDHDate.h
//  XDHTool
//
//  Created by xudehuai on 2017/6/16.
//  Copyright © 2017年 com.xudehuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XDHDate)

/**
 把NSDate按照传入的格式转为时间字符串

 @param formatter 格式
 @return 时间字符串
 */
- (NSString *)xdh_dateStringWithFormatter:(NSString *) formatter;



@end
