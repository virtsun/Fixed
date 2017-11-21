//
//  HFFiixableBaseScrollViewController.h
//  Fixed
//
//  Created by YHL on 2017/11/17.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FiixableBaseScrollDelegate<UIScrollViewDelegate>
@optional
- (void)fiiableCurrentScrollView:(UIScrollView *)scrollview;

@end

@interface HFFiixableBaseScrollViewController : UIViewController

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, weak) id<FiixableBaseScrollDelegate> delegate;

@end
