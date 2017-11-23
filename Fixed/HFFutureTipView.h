//
//  HFFutureTipView.h
//  Fixed
//
//  Created by l.t.zero on 2017/11/23.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFFutureTipView : UIView

@property(nonatomic, assign) CGFloat minScaleHeight;
@property (nonatomic, assign) CGFloat maxHeight;

- (void)updateSigned:(NSInteger)signedCount unSigned:(NSInteger)unSignedCount;

@end
