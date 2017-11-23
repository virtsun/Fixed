//
//  HFFuturStarAllViewController.m
//  Fixed
//
//  Created by l.t.zero on 2017/11/23.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

#import "HFFutureStarAllViewController.h"
#import "HFFutureStarHotCell.h"

@interface HFFutureStarAllViewController ()

@end

@implementation HFFutureStarAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
  //  layout.sectionHeadersPinToVisibleBounds = YES;
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader"];
    [self.collectionView registerClass:[HFFutureStarHotCell class]
            forCellWithReuseIdentifier:NSStringFromClass([HFFutureStarHotCell class])];
    
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
    
    if (indexPath.section == 0){
        UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HFFutureStarHotCell class]) forIndexPath:indexPath];
        cell.backgroundColor = UIColorFromRGB(0xffffff);
        return cell;
    }else{
        UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"content" forIndexPath:indexPath];
        cell.backgroundColor = UIColorFromRGB(arc4random());
        
        cell.layer.cornerRadius = 4;
        cell.layer.shadowColor = UIColorFromRGB(arc4random()).CGColor;
        cell.layer.shadowOpacity = 1.f;
        cell.layer.shadowOffset = CGSizeMake(1, 1);
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(CGRectGetWidth(collectionView.bounds), 50);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                            withReuseIdentifier:@"UICollectionViewHeader"
                                                                                   forIndexPath:indexPath];
    UILabel *label = [reusableView viewWithTag:(NSInteger)@"tag"];
    if (!label){
        label = [[UILabel alloc] initWithFrame:reusableView.bounds];
        label.textColor = UIColorFromRGB(arc4random());
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:20];
        label.tag = (NSInteger)@"tag";
        [reusableView addSubview:label];
        
        label.backgroundColor = UIColorFromRGB(0xffffff);
        label.layer.cornerRadius = 10;
        label.layer.shadowColor = UIColorFromRGB(arc4random()).CGColor;
        label.layer.shadowOpacity = 1.f;
        label.layer.shadowOffset = CGSizeMake(1, 1);
    }
    label.text = @[@"人气之星TOP3", @"星光之星", @"希望之星"][indexPath.section];
    
    return reusableView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 300);
    }else  if (indexPath.section == 1){
        return CGSizeMake(floor((CGRectGetWidth(collectionView.bounds) - 30)/2), floor((CGRectGetWidth(collectionView.bounds) - 30)/2));
    }else{
        return CGSizeMake(floor((CGRectGetWidth(collectionView.bounds) - 40)/3), floor((CGRectGetWidth(collectionView.bounds) - 40)/3));
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0){
        return UIEdgeInsetsMake(10, 0, 10, 0);
    }else{
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
}

@end
