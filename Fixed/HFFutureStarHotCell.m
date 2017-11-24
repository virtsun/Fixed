//
//  HFFutureStarHotCell.m
//  Fixed
//
//  Created by l.t.zero on 2017/11/23.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

#import "HFFutureStarHotCell.h"
#import "HFLoopBannerView.h"
#import "HFGradientCollectionCell.h"

@interface HFFutureStarHotCell()<HFLoopBannerDataSource>
@end

@implementation HFFutureStarHotCell

- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]){
        [self setBanner];
    }
    
    return self;
}
- (void)setBanner{
    HFLoopBannerView *banner = [[HFLoopBannerView alloc] initWithFrame:self.bounds];
    
    [banner registerClass:[HFGradientCollectionCell class] forCellWithReuseIdentifier:@"eeee"];
    banner.enableInfiniteLoop = NO;
    banner.dataSource = self;
    
    [self addSubview:banner];
}

#pragma mark --
#pragma mark -- Banner
- (NSInteger)numberSelectedOfBanners:(HFLoopBannerView *)bannerView{
    return 1;
}
- (NSInteger)numberOfBanners:(HFLoopBannerView *)bannerView{
    return 3;
}
- (CGSize)sizeOfItemAt:(HFLoopBannerView *)bannerView{
    return CGSizeMake(255, CGRectGetHeight(bannerView.bounds) * .8f);
}
- (CGFloat)mutipleOfBannerAt:(HFLoopBannerView *)bannerView{
    return 0.1f;
}

- (CGFloat)marginOfItemsAt:(HFLoopBannerView *)bannerView{
    return 10;
}

- (UICollectionViewCell *)bannerView:(HFLoopBannerView *)bannerView
                        ReusableView:(HFGradientCollectionCell *)reusableView
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
    reusableView.cornerRadius = 3;
    reusableView.borderWidth = 3;
    reusableView.backgroundColor = UIColorFromRGB(arc4random());
//    reusableView.layer.shadowColor = UIColorFromRGB(arc4random()).CGColor;
//    reusableView.layer.shadowOpacity = 1.f;
//    reusableView.layer.shadowOffset = CGSizeMake(1, 1);
    reusableView.layer.masksToBounds = YES;
    
    return reusableView;
}

@end
