//
//  commentsItemModel.m
//  qiushibaike
//
//  Created by longwei on 2017/2/23.
//  Copyright © 2017年 longwei. All rights reserved.
//

#import "commentsItemModel.h"

@implementation commentsItemModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"avartaURL" : @"user.thumb",
             @"userName" : @"user.login",
             };
}
@end
