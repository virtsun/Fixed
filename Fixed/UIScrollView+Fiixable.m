//
//  UIScrollView+Fiixable.m
//  Fixed
//
//  Created by YHL on 2017/11/17.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

#import "UIScrollView+Fiixable.h"
#import <objc/runtime.h>
#import "UIView+Ext.h"

@implementation UIScrollView(Fiixable)

@dynamic relationToFiixable;


- (void)setRelationToFiixable:(BOOL)relationToFiixable{
    objc_setAssociatedObject(self, "relationToFiixable", @(relationToFiixable), OBJC_ASSOCIATION_COPY);
}

- (BOOL)relationToFiixable{
    id fiixable = objc_getAssociatedObject(self, "relationToFiixable");
    return fiixable?[fiixable boolValue]:NO;
}
@end

@implementation UITableView(Fiixable)


- (CGSize)maxzone{
    CGFloat total = CGRectGetHeight(self.tableHeaderView.bounds);
    for (size_t i = 0; i < [self numberOfSections]; i++){
        if (![self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) return CGSizeZero;
        if ([self.delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]){
            total += [self.delegate tableView:self heightForHeaderInSection:i];
        }
        if ([self.delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]){
            total += [self.delegate tableView:self heightForFooterInSection:i];
        }

        for (size_t j = 0; j < [self numberOfRowsInSection:i]; j++){
            CGFloat row = [self.delegate tableView:self heightForRowAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
            
            total += row;
        }
    }
    total += CGRectGetHeight(self.tableFooterView.bounds);
    return CGSizeMake(CGRectGetWidth(self.bounds), total);
}
- (void)sizeToFit{
    CGSize size = [self maxzone];
    NSLog(@"max zone = %@", NSStringFromCGSize(size));
    CGRect frame = self.frame;
    frame.size.width = size.width + self.contentInset.left + self.contentInset.right;
    frame.size.height = size.height + self.contentInset.top + self.contentInset.bottom;
    
    self.frame = frame;
}
@end
