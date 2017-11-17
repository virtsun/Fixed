//
//  HFFiixable ScrollViewController.h
//  Fixed
//
//  Created by YHL on 2017/11/14.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

@import Foundation;
@import UIKit;

@protocol HFFiixableScrollViewDelegate <NSObject>

@optional
- (void)fiixiable:(BOOL)fixed;

@end

@protocol HFFiixableScrollViewDataSource <NSObject>

- (UIView *)headerOfFiixiableScroll;
- (UIView *)fiixiableOfFiixiableScroll;

@end

@interface HFFiixableScrollViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, weak) id<HFFiixableScrollViewDelegate> delegate;
@property (nonatomic, weak) id<HFFiixableScrollViewDataSource> dataSource;

@property (nonatomic, readonly, strong) UIScrollView *scrollView;


- (void)reloadlayout;
- (void)reloadData;

@end
