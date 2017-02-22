//
//  weiboModel.h
//  qiushibaike
//
//  Created by longwei on 2017/2/22.
//  Copyright © 2017年 longwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>
#import "itemModel.h"

@interface weiboModel : NSObject
@property (nonatomic, copy) NSString *err;
@property (nonatomic, assign) UInt64 count;
@property (nonatomic, copy) NSArray<itemModel *> *items;
@property (nonatomic, assign) UInt64 page;
@end
