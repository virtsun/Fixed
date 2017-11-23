//
//  HFFiixableBaseScrollViewController.h
//  Fixed
//
//  Created by YHL on 2017/11/17.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef RGBACOLOR
#define UIColorFromRGBA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
#define UIColorFromRGB(rgbValue) UIColorFromRGBA(rgbValue, 1.f)
#endif

@protocol FiixableBaseScrollDelegate<UIScrollViewDelegate>
@optional
- (void)fiiableCurrentScrollView:(UIScrollView *)scrollview;

@end

@interface HFFiixableBaseScrollViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, weak) id<FiixableBaseScrollDelegate> delegate;

@end
