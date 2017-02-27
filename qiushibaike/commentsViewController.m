//
//  ViewController.m
//  qiushibaike
//
//  Created by longwei on 2017/2/20.
//  Copyright © 2017年 longwei. All rights reserved.
//
#define URL @"http://m2.qiushibaike.com/article/%@/comments?count=20&page=%lld"

#import "commentsViewController.h"
#import "commentsModel.h"
#import "commentsItemModel.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <YYModel/YYModel.h>


@interface commentsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) commentsModel* commentsCollection;

@property (weak, nonatomic) IBOutlet UIView *loadingView;


@end

@implementation commentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.estimatedRowHeight = 400;
    [self fetchDataFromServerWithPage:1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchDataFromServerWithPage:(UInt64)page
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"application/json", @"application/x-javascript",@"text/json", @"text/javascript", @"text/html"]];
    
    NSString *url = [NSString stringWithFormat:URL,self.jokeID,page];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.commentsCollection = [commentsModel yy_modelWithJSON:responseObject];
        //        NSLog(@"%@",responseObject);
        [self.tableView reloadData];
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        self.loadingView.hidden = YES;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"fetchDataFromServerWithPage error = %@",[error localizedDescription]);
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentsCollection.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentsTableCell"
                                                            forIndexPath:indexPath];
    
    commentsItemModel *item = self.commentsCollection.items[indexPath.row];
    UIImageView *avatarImageView = [cell viewWithTag:101];
    UILabel *userLabel = [cell viewWithTag:102];
    UILabel *timeLabel = [cell viewWithTag:103];
    UILabel *contentLabel = [cell viewWithTag:104];
    UILabel *floorLabel = [cell viewWithTag:105];
    
    
    NSString *url = [NSString stringWithFormat:@"http:%@",item.avartaURL];
    [avatarImageView sd_setImageWithURL:[NSURL URLWithString:url]
                       placeholderImage:[UIImage imageNamed:@"qq.png"]
                                options:SDWebImageRefreshCached];
    
    userLabel.text = item.userName;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:item.created_at];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    timeLabel.text = strDate;
    
    contentLabel.text = item.content;
    floorLabel.text = [NSString stringWithFormat:@"%lld楼",item.floor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


@end
