//
//  SLGalleryLayout.m
//  SLPlayer
//
//  Created by L.T.ZERO on 2017/10/26.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

#import "SLGalleryLayout.h"

@interface SLGalleryLayout()

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation SLGalleryLayout
-(id)init{
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;//设置为水平显示
        self.minimumLineSpacing = 0;//cell的最小间隔
        self.indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    return self;
}
- (void) prepareLayout{
    [super prepareLayout];
}

-(CGPoint)targetAContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    //proposedContentOffset是没有设置对齐时本应该停下的位置（collectionView落在屏幕左上角的点坐标）
    
    CGFloat offsetAdjustment = MAXFLOAT;//初始化调整距离为无限大
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);//collectionView落在屏幕中点的x坐标
 
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);//collectionView落在屏幕的大小
    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];//获得落在屏幕的所有cell的属性
    
    //对当前屏幕中的UICollectionViewLayoutAttributes逐个与屏幕中心进行比较，找出最接近中心的一个
    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    //调整
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    //proposedContentOffset是没有设置对齐时本应该停下的位置（collectionView落在屏幕左上角的点坐标）
//    NSArray<UICollectionViewCell *> *visibleCells = self.collectionView.visibleCells;
//    UICollectionViewCell *targetCell;
//    if (proposedContentOffset.x > self.collectionView.contentOffset.x){
//        //向左滑动
//        NSLog(@"向左滑动");
//        targetCell = [visibleCells lastObject];
//        proposedContentOffset.x = CGRectGetMaxX(targetCell.frame);
//    }else{
//        //向右滑动
//        NSLog(@"向右滑动");
//        targetCell = [visibleCells firstObject];
//        proposedContentOffset.x = CGRectGetMinX(targetCell.frame);
//    }

    return [self targetAContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
}


/**
 *  只要显示的边界发生改变就重新布局:
 内部会重新调用prepareLayout和layoutAttributesForElementsInRect方法获得所有cell的布局属性
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

@end
