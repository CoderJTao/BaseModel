//
//  BaseObject.h
//  UtilClass
//
//  Created by JiangT on 2019/3/31.
//  Copyright © 2019 JiangT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseObject : NSObject<NSCoding>

- (void)updateWithJsonDic:(NSDictionary*)jsonDic;

@end

NS_ASSUME_NONNULL_END
