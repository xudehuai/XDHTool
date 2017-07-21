//
//  NSObject+XDHObject.m
//  XDHTool
//
//  Created by xudehuai on 2017/6/21.
//  Copyright © 2017年 com.xudehuai. All rights reserved.
//

#import "NSObject+XDHObject.h"
#import <objc/runtime.h>

@implementation NSObject (XDHObject)

// 生成getter方法
- (SEL)createGetterMethodWithPropertyName:(NSString *)propertyName {
    
    return NSSelectorFromString(propertyName);
}
// 生成setter方法
- (SEL)createSetterMethodWithPropertyName:(NSString *)propertyName {
    
    NSString *methodStr = [[[@"set" stringByAppendingString:[[propertyName substringWithRange:NSMakeRange(0, 1)] uppercaseString]] stringByAppendingString:[propertyName substringWithRange:NSMakeRange(1, propertyName.length - 1)]] stringByAppendingString:@":"];
    
    return NSSelectorFromString(methodStr);
}

- (void)handleNullProperty {
    
    NSString *property_data_type;
    
    u_int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        // 属性名字
        const char *propertyName = property_getName(property);
        // 创建getter方法
        SEL getSel = NSSelectorFromString([NSString stringWithUTF8String:propertyName]);
        // 获取对应属性名的值
        if ([self respondsToSelector:getSel]) {
            // 获得类和方法的签名
            NSMethodSignature *signature = [self methodSignatureForSelector:getSel];
            
            // 从签名获得调用对象
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            
            // 设置target
            [invocation setTarget:self];
            
            // 设置selector
            [invocation setSelector:getSel];
            
            // 接收返回的值
            id __unsafe_unretained returnValue = nil;
            
            // 调用
            [invocation invoke];
            
            // 接收返回值
            [invocation getReturnValue:&returnValue];
            
            if (returnValue == nil) {
                // 属性特性
                const char * property_attr = property_getAttributes(property);
                
                //If the property is a type of Objective-C class, then substring the variable of `property_attr` in order to getting its real type
                if (property_attr[1] == '@') {
                    char * occurs1 =  strchr(property_attr, '@');
                    char * occurs2 =  strrchr(occurs1, '"');
                    char dest_str[40]= {0};
                    strncpy(dest_str, occurs1, occurs2 - occurs1);
                    char * realType = (char *)malloc(sizeof(char) * 50);
                    int i = 0, j = 0, len = (int)strlen(dest_str);
                    for (; i < len; i++) {
                        if ((dest_str[i] >= 'a' && dest_str[i] <= 'z') || (dest_str[i] >= 'A' && dest_str[i] <= 'Z')) {
                            realType[j++] = dest_str[i];
                        }
                    }
                    property_data_type = [NSString stringWithFormat:@"%s", realType];
                    
                    if ([property_data_type isEqualToString:@"NSString"] || [property_data_type isEqualToString:@"NSMutableString"]) {
                        [self setValue:@"" forPropertyName:[NSString stringWithUTF8String:propertyName]];
                    }
                    
                    if ([property_data_type isEqualToString:@"NSArray"] || [property_data_type isEqualToString:@"NSMutableArray"]) {
                        [self setValue:@[] forPropertyName:[NSString stringWithUTF8String:propertyName]];
                    }

                    if ([property_data_type isEqualToString:@"NSDictionary"] || [property_data_type isEqualToString:@"NSMutableDictionary"]) {
                        [self setValue:@{} forPropertyName:[NSString stringWithUTF8String:propertyName]];
                    }
                    
                    free(realType);
                } else {
                    
                    //Otherwise, take the second subscript character for comparing to the @encode()
                    char * realType = [self getPropertyRealType:property_attr];
                    property_data_type = [NSString stringWithFormat:@"%s", realType];
                    
                    if ([property_data_type isEqualToString:@"char"] || [property_data_type isEqualToString:@"unsigned char"]) {
                        [self setValue:@"" forPropertyName:[NSString stringWithUTF8String:propertyName]];
                    }
                    
                    if ([property_data_type isEqualToString:@"int"] ||
                        [property_data_type isEqualToString:@"short"] ||
                        [property_data_type isEqualToString:@"long"] ||
                        [property_data_type isEqualToString:@"long long"] ||
                        [property_data_type isEqualToString:@"unsigned int"] ||
                        [property_data_type isEqualToString:@"unsigned short"] ||
                        [property_data_type isEqualToString:@"unsigned long"] ||
                        [property_data_type isEqualToString:@"unsigned long long"]) {
                        [self setValue:0 forPropertyName:[NSString stringWithUTF8String:propertyName]];
                    }
                    
                    if ([property_data_type isEqualToString:@"float"] || [property_data_type isEqualToString:@"double"]) {
                        [self setValue:0 forPropertyName:[NSString stringWithUTF8String:propertyName]];
                    }
                    
                    if ([property_data_type isEqualToString:@"BOOL"]) {
                        [self setValue:0 forPropertyName:[NSString stringWithUTF8String:propertyName]];
                    }
                    
                }
//                NSLog(@"%@", property_data_type);
            }
            
        }
        
    }
    free(properties);
}

- (char *)getPropertyRealType:(const char *)property_attr {
    char * type;
    
    char t = property_attr[1];
    
    if (strcmp(&t, @encode(char)) == 0) {
        type = "char";
    }
    else if (strcmp(&t, @encode(int)) == 0) {
        type = "int";
    }
    else if (strcmp(&t, @encode(short)) == 0) {
        type = "short";
    }
    else if (strcmp(&t, @encode(long)) == 0) {
        type = "long";
    }
    else if (strcmp(&t, @encode(long long)) == 0) {
        type = "long long";
    }
    else if (strcmp(&t, @encode(unsigned char)) == 0) {
        type = "unsigned char";
    }
    else if (strcmp(&t, @encode(unsigned int)) == 0) {
        type = "unsigned int";
    }
    else if (strcmp(&t, @encode(unsigned short)) == 0) {
        type = "unsigned short";
    }
    else if (strcmp(&t, @encode(unsigned long)) == 0) {
        type = "unsigned long";
    }
    else if (strcmp(&t, @encode(unsigned long long)) == 0) {
        type = "unsigned long long";
    }
    else if (strcmp(&t, @encode(float)) == 0) {
        type = "float";
    }
    else if (strcmp(&t, @encode(double)) == 0) {
        type = "double";
    }
    else if (strcmp(&t, @encode(_Bool)) == 0 || strcmp(&t, @encode(bool)) == 0) {
        type = "BOOL";
    }
    else if (strcmp(&t, @encode(void)) == 0) {
        type = "void";
    }
    else if (strcmp(&t, @encode(char *)) == 0) {
        type = "char *";
    }
    else if (strcmp(&t, @encode(id)) == 0) {
        type = "id";
    }
    else if (strcmp(&t, @encode(Class)) == 0) {
        type = "Class";
    }
    else if (strcmp(&t, @encode(SEL)) == 0) {
        type = "SEL";
    }
    else {
        type = "";
    }
    return type;
}

// 为某个名字的属性进行赋值
- (void)setValue:(id) value forPropertyName:(NSString *) propertyName {
    
    SEL setSel = [self createSetterMethodWithPropertyName:propertyName];
    
    if ([self respondsToSelector:setSel]) {
        
        [self performSelectorOnMainThread:setSel withObject:value waitUntilDone:[NSThread isMainThread]];
    }
}

@end
