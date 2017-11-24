//
//  HFGradientCollectionCell.h
//  Fixed
//
//  Created by l.t.zero on 2017/11/24.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFGradientCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;//可以修改其属性来改变颜色

@end
