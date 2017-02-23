//
//  imageTableViewCell.m
//  qiushibaike
//
//  Created by longwei on 2017/2/23.
//  Copyright © 2017年 longwei. All rights reserved.
//

#import "imageTableViewCell.h"
#import "SCPictureBrowser.h"

@interface imageTableViewCell ()<SCPictureBrowserDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@end

@implementation imageTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bigImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewPressed:)];
    [self.bigImageView addGestureRecognizer:gesture];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)imageViewPressed:(UITapGestureRecognizer *)gesture {
    NSLog(@"imageViewPressed");
    
    SCPictureItem *item = [[SCPictureItem alloc] init];
    item.url = [NSURL URLWithString:self.imageUrl];
    // 如果sourceView为nil，则以其他动画开启和关闭
    item.sourceView = self.bigImageView;
    
    SCPictureBrowser *browser = [[SCPictureBrowser alloc] init];
    browser.items = @[item];
    browser.delegate = self;
    browser.index = 0;
    browser.numberOfPrefetchURLs = 0;
    browser.supportDelete = NO;
    [browser show];
    
}


@end
