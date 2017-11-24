//
//  HFFutureTipView.m
//  Fixed
//
//  Created by l.t.zero on 2017/11/23.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

#import "HFFutureTipView.h"

@interface HFFutureTipView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIImageView *topCImageView;
@property (nonatomic, strong) UIImageView *bottomCImageView;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation HFFutureTipView


- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]){
        self.clipsToBounds = YES;
        self.backgroundColor = UIColorFromRGBA(0xffffff, .1f);
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.image = [UIImage imageNamed:@"home_tuijian_bg"];
        [_backgroundImageView sizeToFit];
        _backgroundImageView.contentMode = UIViewContentModeBottom;
        [self addSubview:_backgroundImageView];
        
        _topCImageView = [[UIImageView alloc] init];
        _topCImageView.image = [UIImage imageNamed:@"home_tuijian_bg1"];
        [_topCImageView sizeToFit];
        [self addSubview:_topCImageView];
        
        _bottomCImageView = [[UIImageView alloc] init];
        _bottomCImageView.image = [UIImage imageNamed:@"home_tuijian_bg2"];
        [_bottomCImageView sizeToFit];
        [self addSubview:_bottomCImageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.text = @"每日为你推荐更优质的偶像艺人";
        [self addSubview:_titleLabel];
        
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textColor = UIColorFromRGBA(0xffaa16, 1.f);
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_tipLabel];
        
        [self updateSigned:15 unSigned:1622];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat rate = (_maxHeight - CGRectGetHeight(self.bounds))/(_maxHeight - _minScaleHeight);
    CGFloat alpha = -1/(10*rate + 1) + 1.1;
    
    _titleLabel.alpha = 1 - alpha;
    _backgroundImageView.alpha = 1-alpha;

    _titleLabel.frame = CGRectMake(0, 65, CGRectGetWidth(self.bounds), 16);
    _tipLabel.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - 20 - 10, CGRectGetWidth(self.bounds), 10);
    _topCImageView.center = CGPointMake(CGRectGetWidth(_topCImageView.bounds)/2, CGRectGetHeight(_topCImageView.frame)/2);
    _bottomCImageView.center = CGPointMake(CGRectGetWidth(self.bounds)-CGRectGetWidth(_bottomCImageView.bounds)/2,
                                           CGRectGetHeight(self.bounds)-CGRectGetHeight(_bottomCImageView.frame)/2);
    _backgroundImageView.frame = self.bounds;

}

- (void)updateSigned:(NSInteger)signedCount unSigned:(NSInteger)unSignedCount{
    NSString *strSigned = [@(signedCount) stringValue];
    NSString *strUnSigned = [@(unSignedCount) stringValue];

    NSString *str = [NSString stringWithFormat:@"今日已签约 %@ 位   今日待签约 %@ 位", strSigned, strUnSigned];
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range = [str rangeOfString:strSigned];
    [attribute addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:range];
    [attribute addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x00ffc8) range:range];
    
    range = [str rangeOfString:strUnSigned];
    [attribute addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:range];
    [attribute addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x00ffc8) range:range];
    _tipLabel.attributedText = attribute;

}
@end
