//
//  UIImage+ThumbnailImage.m
//  lib51PK_IOS
//
//  Created by L.T.ZERO on 14-4-2.
//  Copyright (c) 2014年 iava. All rights reserved.
//

#import "UIImage+scale.h"

@implementation UIImage(scale)

- (UIImage *)imageWithAspectScale:(CGSize)size
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor
                     cornerRadius:(CGFloat)cornerRadius{

    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize scaleSize = CGSizeMake(size.width * scale, size.height * scale);

    CGSize oldSize = self.size;
    CGRect rect;

    if (scaleSize.width/scaleSize.height > oldSize.width/ oldSize.height) {

        rect.size.width = scaleSize.height* oldSize.width/ oldSize.height;
        rect.size.height = scaleSize.height;
        rect.origin.x = (scaleSize.width - rect.size.width)/2;
        rect.origin.y = 0;

    }else{

        rect.size.width = scaleSize.width;
        rect.size.height = scaleSize.width* oldSize.height/ oldSize.width;
        rect.origin.x = 0;
        rect.origin.y = (scaleSize.height - rect.size.height)/2;
    }

    UIGraphicsBeginImageContext(scaleSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(context,YES);//设置线条平滑，不需要两边像素宽

    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    
    UIRectFill(CGRectMake(0, 0, scaleSize.width, scaleSize.height));//clear background

    
    // Drawing code
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    
    //    CGContextAddEllipseInRect(ctx, rect);
    CGContextAddPath(context, path.CGPath);
    CGContextClip(context);
    
    [self drawInRect:rect];

    //填充矩形
    CGContextFillRect(context, rect);
    //设置画笔颜色：黑色
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    //设置画笔线条粗细
    CGContextSetLineWidth(context, borderWidth);
    //画矩形边框
    CGContextAddPath(context, path.CGPath);
    //执行绘画
    CGContextStrokePath(context);
    

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return image;
    
}

- (void)writeToFile:(NSString *)path atomically:(BOOL)atomically{
    NSData *data = UIImageJPEGRepresentation(self, 1.f);
    [data writeToFile:path atomically:atomically];
}

@end
