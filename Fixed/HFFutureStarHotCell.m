//
//  HFFutureStarHotCell.m
//  Fixed
//
//  Created by l.t.zero on 2017/11/23.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

#import "HFFutureStarHotCell.h"
#import "HFLoopBannerView.h"

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
    
    [banner registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"eeee"];
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

@end
