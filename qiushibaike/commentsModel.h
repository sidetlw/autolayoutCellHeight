//
//  commentsModel.h
//  qiushibaike
//
//  Created by longwei on 2017/2/23.
//  Copyright © 2017年 longwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "commentsItemModel.h"

@interface commentsModel : NSObject
@property (nonatomic, copy) NSString *err;
@property (nonatomic, assign) UInt64 count;
@property (nonatomic, copy) NSArray<commentsItemModel *> *items;
@property (nonatomic, assign) UInt64 page;

@end
