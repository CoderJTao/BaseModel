//
//  ViewController.swift
//  UtilClass
//
//  Created by JiangT on 2019/3/20.
//  Copyright © 2019 JiangT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseObject : NSObject<NSCoding>

- (void)updateWithJsonDic:(NSDictionary*)jsonDic;

@end
