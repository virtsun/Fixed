//
//  HFFiixableBaseScrollViewController.m
//  Fixed
//
//  Created by YHL on 2017/11/17.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

#import "HFFiixableBaseScrollViewController.h"
#import <MJRefresh/MJRefresh.h>



@interface HFFiixableBaseScrollViewController ()

@end

@implementation HFFiixableBaseScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    UICollectionViewFlowLayout *_contentLayout = [UICollectionViewFlowLayout new];
    _contentLayout.minimumLineSpacing = 0;
    _contentLayout.minimumInteritemSpacing = 0;
    _contentLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_contentLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_collectionView.mj_header endRefreshing];
        });
    }];
    
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"content"];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if ([self.delegate respondsToSelector:@selector(fiiableCurrentScrollView:)]){
        [self.delegate fiiableCurrentScrollView:_collectionView];
    }
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
    return 100;
    
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"content" forIndexPath:indexPath];

    cell.backgroundColor = UIColorFromRGB(arc4random());
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CGRectGetWidth(collectionView.bounds)/3, CGRectGetHeight(collectionView.bounds)/6);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}

#pragma mark --
#pragma mark -- UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if ([_delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]){
        [_delegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([_delegate respondsToSelector:@selector(scrollViewDidScroll:)]){
        [_delegate scrollViewDidScroll:scrollView ];
    }}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([_delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]){
        [_delegate scrollViewDidEndDecelerating:scrollView];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if ([_delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]){
        [_delegate scrollViewWillBeginDragging:scrollView];
    }
}
@end
