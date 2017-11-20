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
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation BannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    
    [_collectionView performBatchUpdates:^{
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]
                                atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                        animated:NO];
    } completion:^(BOOL finished) {
        NSLog(@"%@", _collectionView.visibleCells);
        [self scrollViewDidScroll:_collectionView];
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
    return 7;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"content" forIndexPath:indexPath];
    
    cell.backgroundColor = UIColorFromRGB(arc4random());
    
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
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {

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

const CGFloat multiple = 0.1;
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSArray<UICollectionViewCell *> *array = _collectionView.visibleCells;
    [array enumerateObjectsUsingBlock:^(UICollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat relationX  = CGRectGetMidX(obj.frame) - scrollView.contentOffset.x;
        
        CGFloat off = fabs(CGRectGetWidth(scrollView.frame)/2 - relationX);
        CGFloat scale = 1 - multiple* off/(CGRectGetWidth(scrollView.frame)/2);
        obj.transform = CGAffineTransformMakeScale(scale, scale);
    }];
    
}
@end
