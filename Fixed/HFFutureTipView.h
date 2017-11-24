//
//  HFFutureTipView.h
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

@interface HFFutureTipView : UIView

@property(nonatomic, assign) CGFloat minScaleHeight;
@property (nonatomic, assign) CGFloat maxHeight;

- (void)updateSigned:(NSInteger)signedCount unSigned:(NSInteger)unSignedCount;

@end
