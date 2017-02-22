//
//  weiboModel.m
//  qiushibaike
//
//  Created by longwei on 2017/2/22.
//  Copyright © 2017年 longwei. All rights reserved.
//

#import "weiboModel.h"

@implementation weiboModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"items" : [itemModel class]
             };
}
@end
