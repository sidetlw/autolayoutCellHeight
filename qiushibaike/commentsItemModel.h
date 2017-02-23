//
//  commentsItemModel.h
//  qiushibaike
//
//  Created by longwei on 2017/2/23.
//  Copyright © 2017年 longwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface commentsItemModel : NSObject
@property (nonatomic,copy) NSString* content;
@property (nonatomic,assign) UInt64 created_at;
@property (nonatomic,copy) NSString* avartaURL;  //user.thumb
@property (nonatomic,copy) NSString* userName;  //user.login
@end
