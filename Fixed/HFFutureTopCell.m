//
//  HFFutureTopCell.m
//  Fixed
//
//  Created by l.t.zero on 2017/11/23.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

#import "HFFutureTopCell.h"

@interface HFFutureTopCell()

@property (nonatomic, strong) UICollectionViewFlowLayout *contentLayout;

@end

@implementation HFFutureTopCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        _numberOfLines = 1;
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:_titleLabel];
        
        _contentLayout = [UICollectionViewFlowLayout new];
        _contentLayout.minimumLineSpacing = 10;
        _contentLayout.minimumInteritemSpacing = 10;
        _contentLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(_titleLabel.frame) + 10, CGRectGetWidth(_titleLabel.bounds), CGRectGetHeight(self.frame) - 10 - CGRectGetHeight(_titleLabel.frame) - 10)
                                             collectionViewLayout:_contentLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.scrollEnabled = NO;
        
        [self addSubview:_collectionView];
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([self class])];
        
    }
    
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(16, 20, CGRectGetWidth(self.bounds) - 32, 20);

    _collectionView.frame = CGRectMake(16, CGRectGetMaxY(_titleLabel.frame) + 10, CGRectGetWidth(_titleLabel.bounds), CGRectGetHeight(self.frame) - 10 - CGRectGetMaxY(_titleLabel.frame) - 10);
}
#pragma mark --
#pragma mark -- Setter && Getter
- (void)setDataSource:(NSArray<NSObject *> *)dataSource{
    _dataSource = [dataSource copy];
    [_collectionView reloadData];
}
- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection{
    _contentLayout.scrollDirection = _scrollDirection =scrollDirection;
    _collectionView.scrollEnabled = _scrollDirection == UICollectionViewScrollDirectionHorizontal;
    [_collectionView reloadData];
}
#pragma mark --
#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataSource.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
    cell.backgroundColor = UIColorFromRGB(arc4random());
    cell.layer.cornerRadius = 4;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(floor((CGRectGetWidth(collectionView.bounds) - 20)/3),
                      (CGRectGetHeight(collectionView.bounds) - 20 - 10 *(_numberOfLines - 1)) / _numberOfLines);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 0, 10, 0);
}
@end
