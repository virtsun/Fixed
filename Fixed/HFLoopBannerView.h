//
//  BannerViewController.h
//  Fixed
//
//  Created by YHL on 2017/11/20.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef RGBACOLOR
#define UIColorFromRGBA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
#define UIColorFromRGB(rgbValue) UIColorFromRGBA(rgbValue, 1.f)
#endif

@class HFLoopBannerView;

@protocol HFLoopBannerDataSource <NSObject>

@optional
- (NSInteger)numberSelectedOfBanners:(HFLoopBannerView *)bannerView;

- (NSInteger)numberOfBanners:(HFLoopBannerView *)bannerView;
- (CGSize)sizeOfItemAt:(HFLoopBannerView *)bannerView;
- (CGFloat)marginOfItemsAt:(HFLoopBannerView *)bannerView;
- (CGFloat)mutipleOfBannerAt:(HFLoopBannerView *)bannerView;//缩放系数默认0.1
- (UICollectionViewCell *)bannerView:(HFLoopBannerView *)bannerView
                            ReusableView:(UICollectionViewCell *)reusableView
                                 atIndex:(NSInteger)index;

@end

@protocol HFLoopBannerDelegate <NSObject>

@optional
- (void)bannerView:(UIView *)bannerView didSelectedIndex:(NSInteger)index;

@end


@interface HFLoopBannerView : UIView

@property (nonatomic, weak) id<HFLoopBannerDataSource> dataSource;
@property (nonatomic, weak) id<HFLoopBannerDelegate> delegate;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) NSInteger autoLoopTimes;
@property (nonatomic, assign) BOOL enableInfiniteLoop;//默认yes

- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;
- (void)reloadData;

@end
