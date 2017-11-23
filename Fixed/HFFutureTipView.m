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

@end

@implementation HFFutureTipView


- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.text = @"每日为你推荐更优质的偶像艺人";
        [self addSubview:_titleLabel];
        
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:_tipLabel];
        
        [self updateSigned:15 unSigned:1622];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _titleLabel.alpha = (1 - (_maxHeight - CGRectGetHeight(self.bounds))/(_maxHeight - _minScaleHeight)) * .5f;
    _titleLabel.frame = CGRectMake(0, 60, CGRectGetWidth(self.bounds), 20);
    _tipLabel.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - 20 - 10, CGRectGetWidth(self.bounds), 10);
}

- (void)updateSigned:(NSInteger)signedCount unSigned:(NSInteger)unSignedCount{
    NSString *strSigned = [@(signedCount) stringValue];
    NSString *strUnSigned = [@(unSignedCount) stringValue];

    NSString *str = [NSString stringWithFormat:@"今日已签约%@位   今日待签约%@位", strSigned, strUnSigned];
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range = [str rangeOfString:strSigned];
    [attribute addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:range];
    [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:range];
    
    range = [str rangeOfString:strUnSigned];
    [attribute addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:range];
    [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:range];
    _tipLabel.attributedText = attribute;

}
@end
