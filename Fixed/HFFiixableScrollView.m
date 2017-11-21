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

@interface HFFiixableScrollView()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIButton *backToTopButton;
@property (nonatomic, assign) BOOL fiexed;

@end

@implementation HFFiixableScrollView


- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
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
    
    if ([_delegate respondsToSelector:@selector(fiixiable:)]){
        [_delegate fiixiable:!_fiexed];
    }
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
    [_backToTopButton setTitle:@"回" forState:UIControlStateNormal];
    [_backToTopButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
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

    if ([_dataSource respondsToSelector:@selector(headerOfFiixiableScroll)]){

        _headerView = [_dataSource headerOfFiixiableScroll];
        
        if (![_scrollView.subviews containsObject:_headerView]){
            [_scrollView addSubview:_headerView];
        }
        _headerView.frame = CGRectMake((CGRectGetWidth(_scrollView.bounds) - CGRectGetWidth(_headerView.bounds))/2, 0,
                                       CGRectGetWidth(_scrollView.bounds), CGRectGetHeight(_headerView.bounds));
    }
    
    if ([_dataSource respondsToSelector:@selector(fiixiableOfFiixiableScroll)]){
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
    [_scrollView setContentOffset:CGPointZero animated:NO];
}
- (void)scrollToTop{

    NSMutableArray *array = [@[] mutableCopy];
    
    if ([_contentView findSubView:[UIScrollView class] allSameType:YES container:array]){
        [array enumerateObjectsUsingBlock:^(UIScrollView *v, NSUInteger idx, BOOL * _Nonnull stop) {
            if(v.relationToFiixable == NO){
                [v setContentOffset:CGPointZero animated:NO];
            }
        }];
    }
    [_scrollView setContentOffset:CGPointZero
                         animated:YES];
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
        [_scrollView setContentOffset:CGPointZero
                             animated:YES];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //处理因子视图向下拖拽而导致父视图无法回到原位置
    if (scrollView == _scrollView) return;
    NSLog(@"scrollViewDidEndDragging: %@", @(decelerate));
    
    if (decelerate){
        CGFloat offsetY = _scrollView.contentOffset.y;
        if (offsetY < 0) {
            [_scrollView setContentOffset:CGPointZero
                                 animated:YES];
        }
    }else{
        NSTimeInterval consume = [[NSDate date] timeIntervalSince1970] - intervalStart;
        CGPoint offset = _scrollView.contentOffset;

        if (offset.y <= 0){
            [_scrollView setContentOffset:CGPointZero
                                 animated:YES];
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
 //   if (!scrollView.scrollEnabled) return;
    
    if (scrollView != _scrollView){
        self.fiexed = round(_scrollView.contentOffset.y - CGRectGetMinY(_contentView.frame)) >= 0;
        CGFloat offsetY = scrollView.contentOffset.y + _scrollView.contentOffset.y;
        if (!self.fiexed) {
            if (_scrollView.contentOffset.y < 0){
                CGPoint offset = _scrollView.contentOffset;
                offset.y += MAX(50/offsetY, offsetY);
                _scrollView.contentOffset = offset;
                NSLog(@"%@", NSStringFromCGPoint(offset));
            }else{
                [_scrollView setContentOffset:CGPointMake(0, MAX(HFFiixableScrollViewMinOffsetY,offsetY))];
            }
            [scrollView setContentOffset:CGPointZero];
        } else if (scrollView.contentOffset.y <= 0 && !self.fiexed) {
            if (_scrollView.contentOffset.y >= CGRectGetMinY(_contentView.frame)) {
                [_scrollView setContentOffset:CGPointMake(0, MAX(HFFiixableScrollViewMinOffsetY,offsetY))];
            }
        }
    }else{
        self.fiexed = round(_scrollView.contentOffset.y - CGRectGetMinY(_contentView.frame)) >= 0;

        if (self.fiexed) {
            [_scrollView setContentOffset:CGPointMake(0, CGRectGetMinY(_contentView.frame))];
        }
    }
}

@end
