//
//  HFFuturStarAllViewController.m
//  Fixed
//
//  Created by l.t.zero on 2017/11/23.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

#import "HFFuturStarAllViewController.h"

@interface HFFuturStarAllViewController ()

@end

@implementation HFFuturStarAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader"];
    
    [self.collectionView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --
#pragma mark -- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 47;
        default:
            break;
    }
    return 100;
    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"content" forIndexPath:indexPath];
    
    cell.backgroundColor = UIColorFromRGB(arc4random());
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(CGRectGetWidth(collectionView.bounds), 30);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                            withReuseIdentifier:@"UICollectionViewHeader"
                                                                                   forIndexPath:indexPath];
    headView.backgroundColor = [UIColor redColor];
    
    return headView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 300);
    }else  if (indexPath.section == 1){
        return CGSizeMake((CGRectGetWidth(collectionView.bounds) - 30)/2, (CGRectGetWidth(collectionView.bounds) - 30)/2);
    }else{
        return CGSizeMake((CGRectGetWidth(collectionView.bounds) - 40)/3, (CGRectGetWidth(collectionView.bounds) - 40)/3);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}

@end
