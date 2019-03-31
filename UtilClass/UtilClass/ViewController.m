//
//  ViewController.m
//  UtilClass
//
//  Created by JiangT on 2019/3/31.
//  Copyright © 2019 JiangT. All rights reserved.
//

#import "ViewController.h"
#import "BaseObject/BaseObject.h"
#import "TestModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDictionary *dic = @{@"name": @"JiangT",
                          @"like": @"code",
                          @"address": @"SH"
                          };
    
    TestModel *model = [[TestModel alloc]init];
    [model updateWithJsonDic:dic];
}


@end
