//
//  commentsModel.m
//  qiushibaike
//
//  Created by longwei on 2017/2/23.
//  Copyright © 2017年 longwei. All rights reserved.
//

#import "commentsModel.h"

@implementation commentsModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"items" : [commentsItemModel class]
             };
}

@end
