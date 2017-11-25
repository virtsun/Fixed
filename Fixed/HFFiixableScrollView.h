//
//  HFFiixable ScrollViewController.h
//  Fixed
//
//  Created by YHL on 2017/11/14.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

@import Foundation;
@import UIKit;

@class HFFiixableScrollView;

@protocol HFFiixableScrollViewDelegate <NSObject>

@optional
- (void)fiixiableScrollView:(HFFiixableScrollView *)scrollView fixed:(BOOL)fixed;
/*parameters:
 *scrollView:当前滚动视图容器-大
 *progress: 距离固定住的进度
 */
- (void)fiixiableScrollView:(HFFiixableScrollView *)scrollView progress:(CGFloat)progress;

@end

@protocol HFFiixableScrollViewDataSource <NSObject>

@required
- (UIView *)headerOfFiixiableScroll;
- (UIView *)fiixiableOfFiixiableScroll;

@optional
- (UIView *)scaleHeaderOfFiixiableScroll;
- (CGFloat)scaleHeaderMinHeightOfFiixiableScroll;

@end

@interface HFFiixableScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic, weak) id<HFFiixableScrollViewDelegate> delegate;
@property (nonatomic, weak) id<HFFiixableScrollViewDataSource> dataSource;

@property (nonatomic, readonly, strong) UIScrollView *scrollView;
@property (nonatomic, weak) UIScrollView *relationScrollView;
@property (nonatomic) UIEdgeInsets safeContentInset;

- (void)scrollToTop;

- (void)reloadlayout;
- (void)reloadData;

@end
