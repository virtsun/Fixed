//
//  UIImage+ThumbnailImage.h
//  lib51PK_IOS
//
//  Created by L.T.ZERO on 14-4-2.
//  Copyright (c) 2014年 iava. All rights reserved.
//

#import <uikit/UIKit.h>

/*略缩图*/
@interface UIImage(scale)

- (UIImage *)imageWithAspectScale:(CGSize)size
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor
                     cornerRadius:(CGFloat)cornerRadius;

@end
