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
    self.backgroundColor = [UIColor clearColor];
    self.delegate = self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.scrollEnabled = NO;
    
    [self registerClass:[HFFutureTopCell class] forCellReuseIdentifier:NSStringFromClass([self class])];
    [self registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"TopHeader"];
    self.tableFooterView = [UIView new];
    if(@available(iOS 11.0, *)){
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

- (void)setBanner{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 200)];
    
    HFLoopBannerView *banner = [[HFLoopBannerView alloc] initWithFrame:CGRectMake(0, 10, CGRectGetWidth(self.bounds), 180)];
    
    [banner registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"eeee"];
//    banner.enableInfiniteLoop = NO;
    banner.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.1f];
    banner.dataSource = self;
    banner.autoLoopTimes = 3;
  
    [header addSubview:banner];
    
    self.tableHeaderView = header;
}
- (void)setFooter{
    UIView *footer = [[UIView alloc] init];

    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.image = [UIImage imageNamed:@"home_bg_ranked"];
    [bgImageView sizeToFit];
    
    footer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(bgImageView.bounds));
    bgImageView.frame = footer.bounds;
    
    [footer addSubview:bgImageView];
    
    
    UIButton *total = [UIButton buttonWithType:UIButtonTypeCustom];
    [total setImage:[UIImage imageNamed:@"home_btn_ranked_zong"] forState: UIControlStateNormal];
    [total sizeToFit];
    [footer addSubview:total];
    
    CGFloat margin = round((CGRectGetWidth(footer.bounds) - CGRectGetWidth(total.bounds) * 3)/4);
    
    total.center = CGPointMake(margin + CGRectGetWidth(total.bounds)/2, 104 + CGRectGetHeight(total.bounds)/2);

    UIButton *month = [UIButton buttonWithType:UIButtonTypeCustom];
    [month setImage:[UIImage imageNamed:@"home_btn_ranked_yue"] forState: UIControlStateNormal];
    [month sizeToFit];
    month.frame = CGRectOffset(total.frame, CGRectGetWidth(total.bounds) + margin, 0);
    [footer addSubview:month];
    
    UIButton *week = [UIButton buttonWithType:UIButtonTypeCustom];
    [week setImage:[UIImage imageNamed:@"home_btn_ranked_zhou"] forState: UIControlStateNormal];
    [week sizeToFit];
    week.frame = CGRectOffset(month.frame, CGRectGetWidth(month.bounds) + margin, 0);

    [footer addSubview:week];
    
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
    
    return reusableView;
}
#pragma mark --
#pragma mark -- UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section > 0?220 : 300;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .01f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TopHeader"];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HFFutureTopCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1f];
    cell.titleLabel.text = @[@"我关注的", @"新进签约艺人", @"热门直播"][indexPath.section];
    cell.numberOfLines = indexPath.section > 0?1:2;//行数根据数据源计算
    cell.scrollDirection =indexPath.section > 0?UICollectionViewScrollDirectionHorizontal:UICollectionViewScrollDirectionVertical;
    cell.dataSource = indexPath.section > 0?@[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"]:@[@"1",@"1",@"1",@"1",@"1",@"1"];

    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
@end
