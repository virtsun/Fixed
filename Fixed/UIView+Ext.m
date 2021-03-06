//
// Created by YHL on 2017/10/26.
// Copyright (c) 2017 l.t.zero. All rights reserved.
//

#import "UIView+Ext.h"


@implementation UIView(Ext)

+ (BOOL)findSubView:(Class)class view:(UIView*)v allSameType:(BOOL)same container:(NSMutableArray *)container{
    __block BOOL found = nil;
    [v.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:class]) {
            found = YES;
            *stop = !same;
            [container addObject:obj];
        }
    }];

    if (!found) {
        [v.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            BOOL tmp = [self findSubView:class view:obj allSameType:same container:container];
            found = found?YES:tmp;
            *stop = found && !same;

        }];
    }

    return found;
}

- (BOOL)findSubView:(Class)class allSameType:(BOOL)same container:(NSMutableArray*)container{
    return [[self class] findSubView:class view:self allSameType:same container:container];
}
- (CGSize)maxzone{
    
    __block CGFloat maxWidth;
    __block CGFloat maxHeight;
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if (obj.alpha >0 && !obj.hidden){
            maxWidth = MAX(maxWidth, CGRectGetMaxX(obj.frame));
            maxHeight = MAX(maxHeight, CGRectGetMaxY(obj.frame));
        }

    }];
    
    return CGSizeMake(MIN(maxWidth, CGRectGetWidth(self.bounds)), MIN(maxHeight, CGRectGetHeight(self.bounds)));
}

@end
