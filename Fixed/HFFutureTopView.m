//
//  HFFiixableTopViewController.m
//  Fixed
//
//  Created by YHL on 2017/11/15.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

#import "HFFutureTopView.h"
#import "UIView+Ext.h"
#import "HFLoopBannerView.h"
#import "HFFutureTopCell.h"

#ifndef RGBACOLOR
#define UIColorFromRGBA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
#define UIColorFromRGB(rgbValue) UIColorFromRGBA(rgbValue, 1.f)
#endif


@interface HFFutureTopView ()<UITableViewDataSource, UITableViewDelegate, HFLoopBannerDataSource>

@property(nonatomic, strong) UIView *tableViewHeader;
@property(nonatomic, strong) UILabel *tipLabel;

@property(nonatomic, assign) BOOL enableShortTip;

@end

@implementation HFFutureTopView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    if (self = [super initWithFrame:frame style:style]){
        [self setupTableView];
        [self setBanner];
        [self setFooter];
    }
    return self;
}

#pragma mark --
#pragma mark -- Layout
- (void)setupTableView{
    
    self.delegate = self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.backgroundColor = [UIColor grayColor];
    self.scrollEnabled = NO;
    
    [self registerClass:[HFFutureTopCell class] forCellReuseIdentifier:NSStringFromClass([self class])];
    [self registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"TopHeader"];
    self.tableFooterView = [UIView new];
    if(@available(iOS 11.0, *)){
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

- (void)setBanner{
    HFLoopBannerView *banner = [[HFLoopBannerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 200)];
    
    [banner registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"eeee"];
//    banner.enableInfiniteLoop = NO;

    banner.dataSource = self;
    banner.autoLoopTimes = 3;
    
    self.tableHeaderView = banner;
}
- (void)setFooter{
    UIView *footer = [[UIView alloc] init];
    footer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), 385.f/2);
    footer.backgroundColor = UIColorFromRGBA(arc4random(), 0.5f);
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 36, CGRectGetWidth(footer.frame), 20);
    titleLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.text = @"明日之星榜";
    [footer addSubview:titleLabel];
    
    CGFloat width = round((CGRectGetWidth(footer.bounds) - 10 * 4)/3);
    
    UIButton *board = [UIButton buttonWithType:UIButtonTypeCustom];
    board.frame = CGRectMake(10, CGRectGetMaxY(titleLabel.frame) + 40, width, 50);
    [board setTitle:@"总排行榜" forState: UIControlStateNormal];
    [board setTitleColor:UIColorFromRGB(arc4random()) forState:UIControlStateNormal];
    
    [footer addSubview:board];

    board = [UIButton buttonWithType:UIButtonTypeCustom];
    board.frame = CGRectMake(10 + (width + 10), CGRectGetMaxY(titleLabel.frame)+ 40, width, 50);
    [board setTitle:@"月排行榜" forState: UIControlStateNormal];
    [board setTitleColor:UIColorFromRGB(arc4random()) forState:UIControlStateNormal];
    
    [footer addSubview:board];
    
    board = [UIButton buttonWithType:UIButtonTypeCustom];
    board.frame = CGRectMake(10 + (width + 10) * 2, CGRectGetMaxY(titleLabel.frame)+ 40, width, 50);
    [board setTitle:@"周排行榜" forState: UIControlStateNormal];
    [board setTitleColor:UIColorFromRGB(arc4random()) forState:UIControlStateNormal];
    
    [footer addSubview:board];
    
    self.tableFooterView = footer;
}

#pragma mark --
#pragma mark -- Banner
- (NSInteger)numberOfBanners:(HFLoopBannerView *)bannerView{
    return 6;
}
- (CGSize)sizeOfItemAt:(HFLoopBannerView *)bannerView{
    return CGSizeMake(280, 160);
}
- (CGFloat)mutipleOfBannerAt:(HFLoopBannerView *)bannerView{
    return 0.0;
}

- (CGFloat)marginOfItemsAt:(HFLoopBannerView *)bannerView{
    return 10;
}

- (UICollectionViewCell *)bannerView:(HFLoopBannerView *)bannerView
                        ReusableView:(UICollectionViewCell *)reusableView
                             atIndex:(NSInteger)index{
    
    UILabel *label = [reusableView viewWithTag:(NSInteger)@"tag"];
    if (!label){
        label = [[UILabel alloc] initWithFrame:reusableView.bounds];
        label.textColor = UIColorFromRGB(arc4random());
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = (NSInteger)@"tag";
        [reusableView addSubview:label];
    }
    label.text = [NSString stringWithFormat:@"%lu",index];
    
    reusableView.backgroundColor = UIColorFromRGB(arc4random());
    reusableView.layer.cornerRadius = 10;
    reusableView.layer.shadowColor = UIColorFromRGB(arc4random()).CGColor;
    reusableView.layer.shadowOpacity = 1.f;
    reusableView.layer.shadowOffset = CGSizeMake(1, 1);
    
    return reusableView;
}
#pragma mark --
#pragma mark -- UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row > 0?220 : 300;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .01f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TopHeader"];
    header.contentView.backgroundColor = UIColorFromRGB(0xffffff);
    return header;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HFFutureTopCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
    cell.backgroundColor = UIColorFromRGB(0xffffff);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = @[@"我关注的", @"新进签约艺人", @"热门直播"][indexPath.row];
    cell.numberOfLines = indexPath.row > 0?1:2;//行数根据数据源计算
    cell.scrollDirection =indexPath.row > 0?UICollectionViewScrollDirectionHorizontal:UICollectionViewScrollDirectionVertical;
    cell.dataSource = indexPath.row > 0?@[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"]:@[@"1",@"1",@"1",@"1",@"1",@"1"];

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
//    if( [indexPath isEqual:[[tableView indexPathsForVisibleRows] lastObject]]){
//        CGSize size = [self maxzone];
//        NSLog(@"max zone = %@", NSStringFromCGSize(size));
//        CGRect frame = self.frame;
//        frame.size.width = size.width + self.contentInset.left + self.contentInset.right;
//        frame.size.height = size.height + self.contentInset.top + self.contentInset.bottom;
//
//        self.frame = frame;
//        
//        if (self.frame_changed_block){
//            self.frame_changed_block();
//        }
//    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    self.enableShortTip = !_enableShortTip;

    [UIView animateWithDuration:.2f animations:^{
        self.contentInset = UIEdgeInsetsMake(_enableShortTip?30:60, 0, 0, 0);
        _tipLabel.frame = CGRectMake(0, -(_enableShortTip?30:60), CGRectGetWidth(self.bounds), _enableShortTip?30:60);
        _tipLabel.text = _enableShortTip?@"有234名偶像等待发现，已经发现238名偶像":@"产品定位 偶像工厂直明星打造基地\n有234名偶像等待发现，已经发现238名偶像";
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:.1f animations:^{
            [self sizeToFit];

        } completion:^(BOOL finished) {
            if (self.frame_changed_block){
                self.frame_changed_block();
            }
        }];
        
        
    }];
}
@end
