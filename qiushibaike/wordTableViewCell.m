//
//  wordTableViewCell.m
//  qiushibaike
//
//  Created by longwei on 2017/2/23.
//  Copyright © 2017年 longwei. All rights reserved.
//

#import "wordTableViewCell.h"

@implementation wordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)buttonTapped:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"commentsButtonTapped" object:nil userInfo:@{@"jokeID":self.jokeID}];
}

@end
