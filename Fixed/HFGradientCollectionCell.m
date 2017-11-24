//
//  HFGradientCollectionCell.m
//  Fixed
//
//  Created by l.t.zero on 2017/11/24.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

#import "HFGradientCollectionCell.h"

@interface HFGradientCollectionCell()

@property(nonatomic, strong) CAShapeLayer *borderLayer;

@end

@implementation HFGradientCollectionCell

- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]){
        
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = self.bounds;
        _imageView.backgroundColor = [UIColor brownColor];
        [self addSubview:_imageView];
        
        _gradientLayer = [[CAGradientLayer alloc] init];
        // 设置阶梯图层的背景
        //gradientLayer.backgroundColor = UIColor.grayColor().CGColor
        // 图层的颜色空间(阶梯显示时按照数组的顺序显示渐进色)
        _gradientLayer.colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor purpleColor].CGColor];
        // 各个阶梯的区间百分比
        _gradientLayer.locations = @[@(0), @(1)];
        _gradientLayer.frame = self.bounds;
        _gradientLayer.position = self.center;
        // 绘图的起点(默认是(0.5,0))
        _gradientLayer.startPoint = CGPointMake(1, 0);
        // 绘图的终点(默认是(0.5,1))
        
        _gradientLayer.endPoint = CGPointMake(0, 1);
        _gradientLayer.masksToBounds = YES;
        [self.layer addSublayer:_gradientLayer];
        
        _borderLayer = [[CAShapeLayer alloc] init];
        _borderLayer.frame = self.bounds;
        _borderLayer.fillColor = [UIColor clearColor].CGColor;
        _borderLayer.strokeColor = [UIColor redColor].CGColor;
        _gradientLayer.mask = _borderLayer;

//        self.layer.mask = _gradientLayer;
//        self.layer.masksToBounds = YES;
    }
    
    return self;
}
- (void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = _cornerRadius;
    self.layer.masksToBounds = YES;

    [self setNeedsDisplay];
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    _borderWidth = borderWidth;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    _borderLayer.lineWidth = _borderWidth;

    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:_cornerRadius];
    _borderLayer.path = bezierPath.CGPath;
    _gradientLayer.mask = _borderLayer;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.gradientLayer.frame = self.bounds;
}
@end
