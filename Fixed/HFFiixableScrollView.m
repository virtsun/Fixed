//
//  HFFiixable ScrollViewController.m
//  Fixed
//
//  Created by YHL on 2017/11/14.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

#import "HFFiixableScrollView.h"
#import "UIView+Ext.h"
#import "UIScrollView+Fiixable.h"

#define HFFiixableScrollViewMinOffsetY (-1100)

@interface HFFiixableScrollView()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *scaleheaderView;
@property (nonatomic, assign) CGFloat minHeightScaleHeader;

@property (nonatomic, strong) UIButton *backToTopButton;
@property (nonatomic, assign) BOOL fiexed;
@property (nonatomic, assign) BOOL locked;

@end

@implementation HFFiixableScrollView


- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
//        self.backgroundColor = [UIColor whiteColor];
        [self setupScene];
    }
    return self;
}

#pragma mark --
#pragma mark -- Setter && Getter

- (void)setDataSource:(id<HFFiixableScrollViewDataSource>)dataSource{
    _dataSource = dataSource;
    
    [self reloadData];
}
- (void)setFiexed:(BOOL)fiexed{
    if (_fiexed == fiexed) return;
    _fiexed = fiexed;
    _backToTopButton.hidden = !fiexed;
    
    if (fiexed){
        _locked = YES;
        _scrollView.relationToFiixable = YES;
    }
    
    if ([_delegate respondsToSelector:@selector(fiixiableScrollView:fixed:)]){
        [_delegate fiixiableScrollView:self fixed:!_fiexed];
    }
}
- (void)setSafeContentInset:(UIEdgeInsets)safeContentInset{
    _scrollView.contentInset = _safeContentInset = safeContentInset;
    [_scrollView setContentOffset:CGPointMake(safeContentInset.left, - safeContentInset.top)];
}
#pragma mark --
#pragma mark -- 基本框架
- (void)setupScene{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    if(@available(iOS 11.0, *)){
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    
    _backToTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backToTopButton.frame = CGRectMake(10, CGRectGetHeight(self.bounds) - 60, 50, 50);
    [_backToTopButton setImage:[UIImage imageNamed:@"Rocket_blue"] forState:UIControlStateNormal];
    _backToTopButton.hidden = YES;

    [_backToTopButton addTarget:self action:@selector(backToTop:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backToTopButton];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self reloadlayout];
}
- (void)reloadlayout{
    _scrollView.frame = self.bounds;
    _minHeightScaleHeader = 0;
    if ([_dataSource respondsToSelector:@selector(scaleHeaderMinHeightOfFiixiableScroll)]){
        _minHeightScaleHeader = [_dataSource scaleHeaderMinHeightOfFiixiableScroll];
    }
    
    if ([_dataSource respondsToSelector:@selector(scaleHeaderOfFiixiableScroll)]){
        
        if (_scaleheaderView && _scaleheaderView.superview){
            [_scaleheaderView removeFromSuperview];
        }
        
        _scaleheaderView = [_dataSource scaleHeaderOfFiixiableScroll];
        
        if (![_scrollView.subviews containsObject:_scaleheaderView]){
            [_scrollView addSubview:_scaleheaderView];
        }
        _scaleheaderView.frame = CGRectMake((CGRectGetWidth(_scrollView.bounds) - CGRectGetWidth(_scaleheaderView.bounds))/2,
                                            0,
                                       CGRectGetWidth(_scrollView.bounds),
                                            CGRectGetHeight(_scaleheaderView.bounds));
    }

    if ([_dataSource respondsToSelector:@selector(headerOfFiixiableScroll)]){

        if (_headerView && _headerView.superview){
            [_headerView removeFromSuperview];
        }
        
        _headerView = [_dataSource headerOfFiixiableScroll];
        
        if (![_scrollView.subviews containsObject:_headerView]){
            [_scrollView addSubview:_headerView];
        }
        _headerView.frame = CGRectMake((CGRectGetWidth(_scrollView.bounds) - CGRectGetWidth(_headerView.bounds))/2,
                                       CGRectGetMaxY(_scaleheaderView.frame),
                                       CGRectGetWidth(_scrollView.bounds),
                                       CGRectGetHeight(_headerView.bounds));
    }
    
    if ([_dataSource respondsToSelector:@selector(fiixiableOfFiixiableScroll)]){
        
        if (_contentView && _contentView.superview){
            [_contentView removeFromSuperview];
        }
        
        _contentView = [_dataSource fiixiableOfFiixiableScroll];

        if (![_scrollView.subviews containsObject:_contentView]){
            [_scrollView addSubview:_contentView];
        }
        _contentView.frame = CGRectMake((CGRectGetWidth(_scrollView.bounds) - CGRectGetWidth(_contentView.bounds))/2, CGRectGetMaxY(_headerView.frame),
                                        CGRectGetWidth(_scrollView.bounds), CGRectGetHeight(_contentView.bounds));
    }
    
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetMaxY(_contentView.frame));
}

- (void)reloadData{
    
    [self reloadlayout];
    [self scrollToOriginalAnimated:NO];
}
- (void)scrollToOriginalAnimated:(BOOL)animated{
    [_scrollView setContentOffset:CGPointMake(_safeContentInset.left, - _safeContentInset.top) animated:animated];
    [self caculateProgressToFix];
}
- (void)scrollToTop{
    _locked = NO;
    _scrollView.relationToFiixable = NO;

    NSMutableArray *array = [@[] mutableCopy];
    
    if ([_contentView findSubView:[UIScrollView class] allSameType:YES container:array]){
        [array enumerateObjectsUsingBlock:^(UIScrollView *v, NSUInteger idx, BOOL * _Nonnull stop) {
            if(v.relationToFiixable == NO){
                [v setContentOffset:CGPointZero animated:NO];
            }
        }];
    }
    [self scrollToOriginalAnimated:YES];
}
- (void)backToTop:(id)sender{
    [self scrollToTop];
}
#pragma mark --
#pragma mark -- UIScrollView
CGPoint pointStart;
NSTimeInterval intervalStart;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == _scrollView) return;
    pointStart = _scrollView.contentOffset;
    intervalStart = [[NSDate date] timeIntervalSince1970];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _scrollView) return;
    CGFloat offsetY = _scrollView.contentOffset.y;
    if (offsetY < 0) {
        [self scrollToOriginalAnimated:YES];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //处理因子视图向下拖拽而导致父视图无法回到原位置
    if (scrollView == _scrollView) return;
//    NSLog(@"scrollViewDidEndDragging: %@", @(decelerate));
    
    if (decelerate){
        CGFloat offsetY = _scrollView.contentOffset.y;
        if (offsetY < 0) {
            [self scrollToOriginalAnimated:YES];
        }
    }else{
        NSTimeInterval consume = [[NSDate date] timeIntervalSince1970] - intervalStart;
        CGPoint offset = _scrollView.contentOffset;

        if (offset.y <= 0){
            [self scrollToOriginalAnimated:YES];
        }else{
            //加速度处理
            CGFloat offsetY = (offset.y - pointStart.y);
            CGFloat a = offsetY/sqrtf(consume);
            offset.y += a * sqrtf(1+consume);

            [_scrollView setContentOffset:CGPointMake(offset.x, MAX(0, offset.y))
                                 animated:YES];
        }
        
    }

}

- (void)reloadlayoutWithOffset:(CGFloat)offset{
    CGFloat scaleHeight = MAX(CGRectGetHeight(_scaleheaderView.bounds) - (offset+_safeContentInset.top), _minHeightScaleHeader);
    _scaleheaderView.frame = CGRectMake((CGRectGetWidth(_scrollView.bounds) - CGRectGetWidth(_scaleheaderView.bounds))/2,
                                        0,
                                        CGRectGetWidth(_scrollView.bounds),
                                        scaleHeight);
    _headerView.frame = CGRectMake((CGRectGetWidth(_scrollView.bounds) - CGRectGetWidth(_headerView.bounds))/2,
                                   CGRectGetMaxY(_scaleheaderView.frame),
                                   CGRectGetWidth(_scrollView.bounds),
                                   CGRectGetHeight(_headerView.bounds));
    
    _contentView.frame = CGRectMake((CGRectGetWidth(_scrollView.bounds) - CGRectGetWidth(_contentView.bounds))/2, CGRectGetMaxY(_headerView.frame),
                                    CGRectGetWidth(_scrollView.bounds), CGRectGetHeight(_contentView.bounds));
    
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetMaxY(_contentView.frame));

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    if (_locked){
//        if (scrollView == _scrollView && self.relationScrollView){
//            CGFloat off = scrollView.contentOffset.y - CGRectGetMinY(_contentView.frame);
//            [self.relationScrollView setContentOffset:CGPointMake(0, _relationScrollView.contentOffset.y + off)];
//        }
        [_scrollView setContentOffset:CGPointMake(0, CGRectGetMinY(_contentView.frame))];
        [self caculateProgressToFix];

        return;
    }
        
    if (scrollView != _scrollView){
        self.fiexed = round(_scrollView.contentOffset.y - CGRectGetMinY(_contentView.frame)) >= 0;
        CGFloat offsetY = scrollView.contentOffset.y + _scrollView.contentOffset.y;
        if (!self.fiexed) {
            if (_scrollView.contentOffset.y < 0){
                CGPoint offset = _scrollView.contentOffset;
                offset.y += MAX(50/offsetY, offsetY);
                _scrollView.contentOffset = offset;
                [self caculateProgressToFix];

            }else{
                if (_scrollView.contentOffset.y > -_safeContentInset.top && CGRectGetHeight(_scaleheaderView.bounds) > _minHeightScaleHeader){
                    [self reloadlayoutWithOffset:offsetY];
                    [self scrollToOriginalAnimated:NO];
                    [self caculateProgressToFix];
                }else{
                    [_scrollView setContentOffset:CGPointMake(0, MAX(HFFiixableScrollViewMinOffsetY,offsetY))];
                    [self caculateProgressToFix];

                }
            }
            [scrollView setContentOffset:CGPointZero];
        } else if (scrollView.contentOffset.y <= 0 && !self.fiexed) {
            if (_scrollView.contentOffset.y >= CGRectGetMinY(_contentView.frame)) {
                [_scrollView setContentOffset:CGPointMake(0, MAX(HFFiixableScrollViewMinOffsetY,offsetY))];
            }
            [self caculateProgressToFix];

        }
    }else{
        self.fiexed = round(_scrollView.contentOffset.y - CGRectGetMinY(_contentView.frame)) >= 0;

        if (self.fiexed) {
            [_scrollView setContentOffset:CGPointMake(0, CGRectGetMinY(_contentView.frame))];
            [self caculateProgressToFix];

        }else{
            if (_scrollView.contentOffset.y > -_safeContentInset.top && CGRectGetHeight(_scaleheaderView.bounds) > _minHeightScaleHeader){
                [self reloadlayoutWithOffset:_scrollView.contentOffset.y];
                [self scrollToOriginalAnimated:NO];
            }
            [self caculateProgressToFix];

        }
    }
}

- (void)caculateProgressToFix{
    if ([_delegate respondsToSelector:@selector(fiixiableScrollView:progress:)]){
        if (_scrollView.contentOffset.y < 0){
            [_delegate fiixiableScrollView:self progress:0];
        }else{
            CGFloat totalH = CGRectGetMinY(_contentView.frame);
            CGFloat rate = (_scrollView.contentOffset.y)/totalH;
            CGFloat curve = -1/(10*rate + 1) + 1.1;
            [_delegate fiixiableScrollView:self progress:curve];
        }
 
    }
    
}

@end
