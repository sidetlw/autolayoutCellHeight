//
//  myTableViewController.m
//  qiushibaike
//
//  Created by longwei on 2017/2/20.
//  Copyright © 2017年 longwei. All rights reserved.
//

#define URL @"http://m2.qiushibaike.com/article/list/suggest?count=20&page="
#define weakSelf(__TARGET__) __weak typeof(self) __TARGET__=self

#import "myTableViewController.h"
#import "imageTableViewCell.h"
#import "wordTableViewCell.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "weiboModel.h"


@interface myTableViewController ()
@property (nonatomic,strong) weiboModel* weiboCollection;

@end

@implementation myTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.estimatedRowHeight = 400;
    [self fetchDataFromServerWithPage:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize

{
    
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            //原图是竖条
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = 0; //(asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            //横条
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = 0;//(asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, rect.size.width, rect.size.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return newimage;
}

-(void)fetchDataFromServerWithPage:(UInt64)page
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"application/json", @"application/x-javascript",@"text/json", @"text/javascript", @"text/html"]];
    
    NSString *url = [URL stringByAppendingFormat:@"%llu",page];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.weiboCollection = [weiboModel yy_modelWithJSON:responseObject];
//        NSLog(@"%@",responseObject);
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"fetchDataFromServerWithPage error = %@",[error localizedDescription]);
    }];
}

-(UIImage *)smallImge:(UIImage *)image size:(CGSize)size
{
    UIImage *smallImage = image;
//    CGSize oldsize = image.size;
    CGSize oldsize = size;
    if (oldsize.height > 200 || oldsize.width > 200) {
        if (oldsize.width >= oldsize.height) {
            CGFloat height = 200 * (oldsize.height / oldsize.width);
            smallImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(200, height)];
        }
        else {
            CGFloat width = 200 * oldsize.width / oldsize.height;
            smallImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(width, 200)];
        }
    }
    return smallImage;
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.weiboCollection.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tabelViewcellNoImage"
                                                            forIndexPath:indexPath];
    
    itemModel *item = self.weiboCollection.items[indexPath.row];
    if ([item.format isEqualToString:@"word"]) {
       wordTableViewCell* wordcell = [tableView dequeueReusableCellWithIdentifier:@"tabelViewcellNoImage" forIndexPath:indexPath];
       
        cell = wordcell;
        UIImageView *avatarImageView = [cell viewWithTag:101];
        UILabel *userLabel = [cell viewWithTag:102];
        UILabel *timeLabel = [cell viewWithTag:103];
        UILabel *contentLabel = [cell viewWithTag:104];
        

        NSString *url = [NSString stringWithFormat:@"http:%@",item.avartaURL];
         [avatarImageView sd_setImageWithURL:[NSURL URLWithString:url]
                            placeholderImage:[UIImage imageNamed:@"qq.png"]
                                     options:SDWebImageRefreshCached];
        
        userLabel.text = item.userName;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:item.published_at];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *strDate = [dateFormatter stringFromDate:date];
        timeLabel.text = strDate;
        
        contentLabel.text = item.content;
        
        NSString *title = [NSString stringWithFormat:@"评论(%lld)",item.comments_count];
        [wordcell.commentsButton setTitle:title forState:UIControlStateNormal];

    }
    else if ([item.format isEqualToString:@"image"]) {
        imageTableViewCell *imageCell = (imageTableViewCell*)([tableView dequeueReusableCellWithIdentifier:@"tabelViewcellWithImage" forIndexPath:indexPath]);

        cell = imageCell;
        UIImageView *avatarImageView = [cell viewWithTag:201];
        UILabel *userLabel = [cell viewWithTag:202];
        UILabel *timeLabel = [cell viewWithTag:203];
        UILabel *contentLabel = [cell viewWithTag:204];
        UIImageView *imageView = [cell viewWithTag:205];
        
        NSString *url = [NSString stringWithFormat:@"http:%@",item.avartaURL];
        [avatarImageView sd_setImageWithURL:[NSURL URLWithString:url]
                           placeholderImage:[UIImage imageNamed:@"qq.png"]
                                    options:SDWebImageRefreshCached];
        
        userLabel.text = item.userName;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:item.published_at];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *strDate = [dateFormatter stringFromDate:date];
        timeLabel.text = strDate;
        
        contentLabel.text = item.content;
        NSString *title = [NSString stringWithFormat:@"评论(%lld)",item.comments_count];
        [imageCell.commentsButton setTitle:title forState:UIControlStateNormal];
        
        CGFloat width = [item.image_size[@"s"][0] floatValue];
        CGFloat height = [item.image_size[@"s"][1] floatValue];
        CGSize imageSize = CGSizeMake(width, height);
        CGFloat constraintWidth = 200 * width / height;
        if (height > width) {
            imageCell.constraintOfImage.constant = constraintWidth;
        }
        else {
            imageCell.constraintOfImage.constant = 200;
        }
        
        NSString *url2 = [NSString stringWithFormat:@"http:%@",item.low_loc];
        NSString *high_loc_url = [NSString stringWithFormat:@"http:%@",item.high_loc];
        imageCell.imageUrl = high_loc_url;
        UIImage *whiteimage = [UIImage imageNamed:@"whitePape"];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:url2]
                     placeholderImage:[self smallImge:whiteimage size:imageSize]
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                UIImage *smallImage = [self smallImge:image size:imageSize];
                                imageView.image = smallImage;
                            }];
    }
    else {
        NSLog(@"cell format error");
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
