//
//  BannerViewController.m
//  Fixed
//
//  Created by YHL on 2017/11/20.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

#import "BannerViewController.h"
#import "SLGalleryLayout.h"

#ifndef RGBACOLOR
#define UIColorFromRGBA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
#define UIColorFromRGB(rgbValue) UIColorFromRGBA(rgbValue, 1.f)
#endif

@interface BannerViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) id<UIScrollViewDelegate> delegate;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) NSInteger itemCount;

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) BOOL loop;
@property (nonatomic, copy) NSArray *dataSource;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation BannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataSource = @[@"4",@"5",@"1",@"2",@"3",@"4",@"5",@"1",@"2"];
    _itemCount = _dataSource.count;

    _itemSize = CGSizeMake(300, CGRectGetHeight(self.view.bounds) * 0.8);
    UICollectionViewFlowLayout *_contentLayout = [SLGalleryLayout new];
    _contentLayout.minimumLineSpacing = 0;
    _contentLayout.minimumInteritemSpacing = 0;
    _contentLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_contentLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.alwaysBounceHorizontal = YES;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"content"];

    [self.view addSubview:_collectionView];
    self.selectedIndex = 2;
    [_collectionView performBatchUpdates:^{
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex  inSection:0]
                                atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                        animated:YES];
    } completion:^(BOOL finished) {
        NSLog(@"%@", _collectionView.visibleCells);
        [self scrollLayout:_collectionView loop:NO];
    }];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.f repeats:YES block:^(NSTimer * _Nonnull timer) {
        [_collectionView performBatchUpdates:^{
            [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex + 1  inSection:0]
                                    atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                            animated:YES];
        } completion:^(BOOL finished) {
            NSLog(@"%@", _collectionView.visibleCells);
        //    [self scrollLayout:_collectionView loop:NO];
            self.selectedIndex++;
        }];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    _collectionView.frame = self.view.bounds;
}

#pragma mark --
#pragma mark -- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"content" forIndexPath:indexPath];
    
    UILabel *label = [cell viewWithTag:(NSInteger)@"tag"];
    if (!label){
        label = [[UILabel alloc] initWithFrame:cell.bounds];
        label.textColor = UIColorFromRGB(arc4random());
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = (NSInteger)@"tag";
        [cell addSubview:label];
    }
    label.text = _dataSource[indexPath.row];

    cell.backgroundColor = UIColorFromRGB(0xff0000);
    cell.layer.cornerRadius = 10;
    cell.layer.shadowColor = UIColorFromRGB(arc4random()).CGColor;
    cell.layer.shadowOpacity = 1.f;
    cell.layer.shadowOffset = CGSizeMake(1, 1);
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return _itemSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
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
- (void)scrollToIndex:(NSInteger)idx from:(NSInteger)from{
    
    CGFloat x = (idx)*(_itemSize.width) + _itemSize.width/2 - CGRectGetWidth(_collectionView.bounds)/2;
    NSLog(@"target === %f", x);
    CGFloat x1 = (from)*(_itemSize.width) + _itemSize.width/2 - CGRectGetWidth(_collectionView.bounds)/2;

    [_collectionView performBatchUpdates:^{
        [_collectionView setContentOffset:CGPointMake(x1, 0) animated:YES];
    } completion:^(BOOL finished) {
        [_collectionView performBatchUpdates:^{
            [_collectionView setContentOffset:CGPointMake(x, 0) animated:NO];
        } completion:^(BOOL finished) {
            NSLog(@"%@", _collectionView.visibleCells);
            [self scrollLayout:_collectionView loop:NO];
            self.selectedIndex = idx;
        }];
    }];
    
    
    
}

const CGFloat multiple = 0.1;
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
        
        if (fabs(scale - 1) < 0.05f && loop){
            NSIndexPath *indexPath = [_collectionView indexPathForCell:obj];

            if (lastPoint.x > scrollView.contentOffset.x){
                //向右滑动
                if (indexPath.row == 2 && self.selectedIndex == 2){
                    NSLog(@"向右滑动 到达初始");
                    NSLog(@"scale:%lf", scale);

                    [self scrollToIndex:_itemCount - 2 from:2];
                }

            }else{
                //向左滑动
                if (indexPath.row == _itemCount - 2 && self.selectedIndex == _itemCount - 2){
                    NSLog(@"向左滑动到达末尾");
                    NSLog(@"scale:%lf", scale);

                    [self scrollToIndex:2 from:_itemCount - 2];

                }
            }
        }
    }];
    lastPoint = scrollView.contentOffset;
}
@end
