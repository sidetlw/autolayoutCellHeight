//
//  imageTableViewCell.h
//  qiushibaike
//
//  Created by longwei on 2017/2/23.
//  Copyright © 2017年 longwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface imageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *commentsButton;
@property (nonatomic,copy) NSString *imageUrl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintOfImage;
@property (nonatomic,assign) NSString* jokeID;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightOfImage;

@end
