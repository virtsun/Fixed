//
//  CircleImageView.h
//  JenkinsDemo
//
//  Created by YHL on 2017/9/13.
//  Copyright © 2017年 L.T.ZERO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleImageView : UIImageView

@property (nonatomic, assign) CGFloat strokeWidth;
@property (nonatomic, assign) CGFloat cornerRadius;

@property (nonatomic, copy) UIColor *strokeColor;


@end
