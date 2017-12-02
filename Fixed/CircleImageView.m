//
//  CircleImageView.m
//  JenkinsDemo
//
//  Created by YHL on 2017/9/13.
//  Copyright © 2017年 L.T.ZERO. All rights reserved.
//

#import "CircleImageView.h"
#import "UIImage+scale.h"

@interface CircleImageView()

@property (nonatomic, strong) UIImage *originImage;

@end

@implementation CircleImageView{
}

- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)setImage:(UIImage *)image{
    _originImage = image;
    UIImage *img = [_originImage imageWithAspectScale:self.bounds.size
                                          borderWidth:_strokeWidth
                                          borderColor:_strokeColor
                                         cornerRadius:_cornerRadius];
    [super setImage:img];
}

- (void)setStrokeColor:(UIColor *)strokeColor{
    _strokeColor = strokeColor;
    self.image = _originImage;
}

- (void)setStrokeWidth:(CGFloat)strokeWidth{
    _strokeWidth = strokeWidth;
    self.image = _originImage;
}
- (void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    self.image = _originImage;
}

@end
