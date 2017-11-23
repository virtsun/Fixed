//
//  HFFutureTopCell.h
//  Fixed
//
//  Created by l.t.zero on 2017/11/23.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#ifndef RGBACOLOR
#define UIColorFromRGBA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
#define UIColorFromRGB(rgbValue) UIColorFromRGBA(rgbValue, 1.f)
#endif

typedef NS_ENUM(NSInteger, HFFutureTopCellType){
    kHFFutureTopCellTypeFocus,
    kHFFutureTopCellTypeArtist,
    kHFFutureTopCellTypeLive
};


@interface HFFutureTopCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) NSInteger numberOfLines;//行数

@property (nonatomic, copy) NSArray<NSObject *> *dataSource;
@property (nonatomic) UICollectionViewScrollDirection scrollDirection; // default is UICollectionViewScrollDirectionVertical

@end
