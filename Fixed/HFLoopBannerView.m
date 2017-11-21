//
//  BannerViewController.m
//  Fixed
//
//  Created by YHL on 2017/11/20.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

#import "HFLoopBannerView.h"


#define MAX_COUNT 999

@interface HFLoopBannerView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) NSInteger itemCount;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL timerStop;
@property (nonatomic, copy) NSString *identifier;

@end

@implementation HFLoopBannerView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        
    }
    // Do any additional setup after loading the view.
    self.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *_contentLayout = [UICollectionViewFlowLayout new];
    _contentLayout.minimumLineSpacing = 0;
    _contentLayout.minimumInteritemSpacing = 0;
    _contentLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_contentLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.alwaysBounceHorizontal = YES;
    
    _identifier = NSStringFromClass([self class]);
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:_identifier];
    
    [self addSubview:_collectionView];
   
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    _collectionView.frame = self.bounds;
}

- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier{
    _identifier = [identifier copy];
    [_collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
}
#pragma mark --
#pragma mark -- Setter & Getter

- (void)setDataSource:(id<HFLoopBannerDataSource>)dataSource{
    _dataSource = dataSource;
    [self reloadData];
}
- (void)setAutoLoopTimes:(NSInteger)autoLoopTimes{
    if ((_autoLoopTimes = autoLoopTimes) > 0){
        [_timer invalidate];
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.f repeats:YES block:^(NSTimer * _Nonnull timer) {
            [_collectionView performBatchUpdates:^{
                [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex + 1  inSection:0]
                                        atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                                animated:YES];
            } completion:^(BOOL finished) {
                self.selectedIndex++;
                [self scrollViewDidEndScroll:YES];
            }];
        }];
    }else{
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)startTimer{
    if (_timerStop){
        [_timer performSelector:@selector(setFireDate:) withObject:[NSDate distantPast] afterDelay:_autoLoopTimes];
        _timerStop = NO;
    }

}
- (void)stopTimer{
    [_timer setFireDate:[NSDate distantFuture]];
    _timerStop = YES;
}
#pragma mark --
#pragma mark -- UICollectionViewDataSource

- (void)reloadData{
    _itemCount = 0;
    if ([_dataSource respondsToSelector:@selector(numberOfBannerCount)]){
        _itemCount = [_dataSource numberOfBannerCount];
    }
    
    if ([_dataSource respondsToSelector:@selector(sizeOfBanner)]){
        _itemSize = [_dataSource sizeOfBanner];
    }
    if ([_dataSource respondsToSelector:@selector(mutipleOfBanner)]){
        multiple = [_dataSource mutipleOfBanner];
    }
    
    [_collectionView reloadData];
    
    self.selectedIndex = ((MAX_COUNT/_itemCount)/2) * _itemCount;
    [_collectionView performBatchUpdates:^{
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex  inSection:0]
                                atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                        animated:YES];
    } completion:^(BOOL finished) {
        NSLog(@"%@", _collectionView.visibleCells);
        [self scrollLayout:_collectionView loop:NO];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _itemCount>0?MAX_COUNT:0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:_identifier forIndexPath:indexPath];
   
    if ([_dataSource respondsToSelector:@selector(bannerView:ReusableView:atIndex:)]){
        cell = [_dataSource bannerView:self ReusableView:cell atIndex:indexPath.row%_itemCount];
    }

    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return _itemSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    NSArray<UICollectionViewCell *> *visibleCells = self.collectionView.visibleCells;
    UICollectionViewCell *targetCell = [visibleCells firstObject];
    
    NSIndexPath *indexPath = nil;
    if (fabs((*targetContentOffset).x - scrollView.contentOffset.x) > 30){
        if ((*targetContentOffset).x > scrollView.contentOffset.x){
            
            [visibleCells enumerateObjectsUsingBlock:^(UICollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSIndexPath *indexPath = [_collectionView indexPathForCell:obj];
                self.selectedIndex = MAX(self.selectedIndex, indexPath.row);
            }];
            
            if (self.selectedIndex >= [self collectionView:_collectionView numberOfItemsInSection:0]){
                self.selectedIndex = [self collectionView:_collectionView numberOfItemsInSection:0] - 1;
                return;
            }
            
        }else{
            [visibleCells enumerateObjectsUsingBlock:^(UICollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSIndexPath *indexPath = [_collectionView indexPathForCell:obj];
                self.selectedIndex = MIN(self.selectedIndex, indexPath.row);
            }];
            
            if (self.selectedIndex < 0){
                self.selectedIndex = 0;
                return;
            }
            
        }
    }
    
    NSLog(@"target : %lu", self.selectedIndex);
    
    indexPath = [NSIndexPath indexPathForRow:self.selectedIndex inSection:0];
    targetCell = [_collectionView cellForItemAtIndexPath:indexPath];
    
    CGFloat x = CGRectGetMidX(targetCell.frame) - CGRectGetWidth(scrollView.bounds)/2;
    *targetContentOffset = CGPointMake(x, scrollView.contentOffset.y);
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 停止类型1、停止类型2
    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging &&    !scrollView.decelerating;
    if (scrollToScrollStop) {
        [self scrollViewDidEndScroll];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        // 停止类型3
        BOOL dragToDragStop = scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
        if (dragToDragStop) {
            [self scrollViewDidEndScroll];
        }
    }
}
- (void)scrollViewDidEndScroll{
    [self scrollViewDidEndScroll:NO];
}
- (void)scrollViewDidEndScroll:(BOOL)autoLoop {
    
    [self startTimer];
    
    NSInteger target = ((MAX_COUNT/_itemCount)/2) * _itemCount + (self.selectedIndex) %_itemCount;
    
    if (labs(target - self.selectedIndex) > 10){
        self.selectedIndex = autoLoop?target - 1:target;
        [_collectionView performBatchUpdates:^{
            [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex  inSection:0]
                                    atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                            animated:NO];
        } completion:^(BOOL finished) {
            [self scrollLayout:_collectionView loop:NO];
        }];
    }
   
}

CGFloat multiple = 0.1;
static CGPoint lastPoint;
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self scrollLayout:scrollView loop:YES];
}
-(void)scrollLayout:(UIScrollView *)scrollView loop:(BOOL)loop{
    NSArray<UICollectionViewCell *> *array = _collectionView.visibleCells;
    [array enumerateObjectsUsingBlock:^(UICollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat relationX  = CGRectGetMidX(obj.frame) - scrollView.contentOffset.x;
        
        CGFloat off = fabs(CGRectGetWidth(scrollView.frame)/2 - relationX);
        CGFloat scale = 1 - multiple* off/(CGRectGetWidth(scrollView.frame)/2);
        obj.transform = CGAffineTransformMakeScale(scale, scale);
    }];
    lastPoint = scrollView.contentOffset;
}
@end

