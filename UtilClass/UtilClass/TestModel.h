//
//  TestModel.h
//  UtilClass
//
//  Created by JiangT on 2019/3/31.
//  Copyright © 2019 JiangT. All rights reserved.
//

#import "BaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestModel : BaseObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *like;

@end

NS_ASSUME_NONNULL_END
