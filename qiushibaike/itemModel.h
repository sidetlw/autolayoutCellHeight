//
//  itemModel.h
//  qiushibaike
//
//  Created by longwei on 2017/2/22.
//  Copyright © 2017年 longwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

@interface itemModel : NSObject
@property (nonatomic,copy) NSString* format;
@property (nonatomic,copy) NSString* image;
@property (nonatomic,copy) NSString* high_loc;  //大图
@property (nonatomic,copy) NSString* low_loc;  //小图
@property (nonatomic,assign) UInt64 published_at;
@property (nonatomic,copy) NSString* avartaURL;  //user.thumb
@property (nonatomic,copy) NSString* userName;  //user.login
@property (nonatomic,copy) NSDictionary* image_size; //user.image_size
@property (nonatomic,copy) NSString *content;
@property (nonatomic,assign) UInt64 comments_count;

@end
