//
//  BaseObject.m
//  UtilClass
//
//  Created by JiangT on 2019/3/31.
//  Copyright © 2019 JiangT. All rights reserved.
//

#import "BaseObject.h"
#import <objc/runtime.h>

@implementation BaseObject

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self codeDataWithCoder:aDecoder isEncoding:YES];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self codeDataWithCoder:aCoder isEncoding:NO];
}

- (void)codeDataWithCoder:(NSCoder *)coder isEncoding:(BOOL)isEncoding
{
    Class cls = [self class];
    unsigned int numberOfIvars = 0;
    Ivar* ivars = class_copyIvarList(cls, &numberOfIvars);
    for(const Ivar* p = ivars; p < ivars+numberOfIvars; p++)
    {
        Ivar const ivar = *p;
        const char *ivar_type = ivar_getTypeEncoding(ivar);
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        if (isEncoding) {
            NSObject* value = nil;
            
            //For bool value
            if (strcmp(ivar_type, "c") == 0) {
                BOOL boolVal = [coder decodeBoolForKey:key];
                value = [NSNumber numberWithBool:boolVal];
                
                [self setValue:value forKey:key];
                //For NSInteger value
            } else if(strcmp(ivar_type, "i") == 0) {
                NSInteger intVal = [coder decodeIntegerForKey:key];
                value = [NSNumber numberWithInteger:intVal];
                
                [self setValue:value forKey:key];
            } else {
                value = [coder decodeObjectForKey:key];
                
                if(value)
                {
                    NSString* st_property_type = [NSString stringWithCString:ivar_type encoding:NSUTF8StringEncoding];
                    if( [st_property_type hasPrefix:@"@\""] && [st_property_type hasSuffix:@"\""] && st_property_type.length > 3 )
                    {
                        NSRange range = NSMakeRange(2, st_property_type.length - 3);
                        st_property_type = [st_property_type substringWithRange:range];
                    }
                    Class cls_property = NSClassFromString(st_property_type);
                    Class cls_value = [value class];
                    
                    if ( cls_property == cls_value || [cls_property isSubclassOfClass:cls_value] || [cls_value isSubclassOfClass:cls_property] )
                    {
                        [self setValue:value forKey:key];
                    }
                }
            }
        } else {
            //For bool value
            if (strcmp(ivar_type, "c") == 0) {
                BOOL boolVal = [(NSNumber*)[self valueForKey:key] boolValue];
                [coder encodeBool:boolVal forKey:key];
                //For NSInteger value
            } else if(strcmp(ivar_type, "i") == 0) {
                NSInteger intVal = [(NSNumber*)[self valueForKey:key] intValue];
                [coder encodeInteger:intVal forKey:key];
            } else {
                [coder encodeObject:[self valueForKey:key] forKey:key];
            }
        }
    }
    free(ivars);
}



- (void)updateWithJsonDic:(NSDictionary*)jsonDic
{
    for (NSString *key in [jsonDic allKeys]) {
        id value = [jsonDic objectForKey:key];
        
        if (![value isKindOfClass:[NSString class]]) {
            //            NSLog(@"Non stringValue for key: %@, value:%@, valueCalss:%@", key, value, [value class]);
        }
        
        if ([value isKindOfClass:[NSNull class]]) {
            continue;
        }
        [self setValue:[jsonDic objectForKey:key] forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"Found an undifined key: %@, value: %@", key, value);
    return;
}

@end
