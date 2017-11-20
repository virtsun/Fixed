//
//  HFFiixableTopViewController.m
//  Fixed
//
//  Created by YHL on 2017/11/15.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

#import "HFFiixableTopView.h"
#import "SLGalleryLayout.h"
#import "UIView+Ext.h"

#ifndef RGBACOLOR
#define UIColorFromRGBA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
#define UIColorFromRGB(rgbValue) UIColorFromRGBA(rgbValue, 1.f)
#endif

@implementation HFFiixableTopViewHeader

@end


@interface HFFiixableTopView ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UIView *tableViewHeader;
@property(nonatomic, strong) UILabel *tipLabel;

@property(nonatomic, assign) BOOL enableShortTip;

@end

@implementation HFFiixableTopView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    if (self = [super initWithFrame:frame style:style]){
        [self setupTableView];
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
    
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([self class])];
    [self registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"TopHeader"];
    self.tableFooterView = [UIView new];
    if(@available(iOS 11.0, *)){
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    _tipLabel = [[UILabel alloc] init];
    _tipLabel.frame = CGRectMake(0, -60, CGRectGetWidth(self.bounds), 60);
    _tipLabel.text = _enableShortTip?@"有234名偶像等待发现，已经发现238名偶像":@"产品定位 偶像工厂直明星打造基地\n有234名偶像等待发现，已经发现238名偶像";
    _tipLabel.textColor = [UIColor whiteColor];
    _tipLabel.numberOfLines = 2;
    _tipLabel.textAlignment = NSTextAlignmentCenter;
  //  _tipLabel.backgroundColor = [UIColor grayColor];
    _tipLabel.font = [UIFont systemFontOfSize:12];
    
    [self addSubview:_tipLabel];
    
    self.contentInset = UIEdgeInsetsMake(CGRectGetHeight(_tipLabel.bounds), 0, 0, 0);
    
    UIView *tableHeader = [UIView new];
    tableHeader.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), 30);
    tableHeader.backgroundColor = UIColorFromRGB(arc4random());
    
    self.tableHeaderView = tableHeader;

}

#pragma mark --
#pragma mark -- UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}
- (UIView* )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TopHeader"];
    header.contentView.backgroundColor = UIColorFromRGB(0xffffff);
    header.textLabel.text = @"我关注的 ";
    header.textLabel.font = [UIFont systemFontOfSize:13];
    header.textLabel.textColor = UIColorFromRGB(0x000000);
    return header;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
    cell.backgroundColor = UIColorFromRGB(0xffffff);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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