//
//  HFFiixableTopViewController.h
//  Fixed
//
//  Created by YHL on 2017/11/15.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFFiixableTopViewHeader : UITableViewHeaderFooterView

@end

@interface HFFiixableTopView : UITableView

@property(nonatomic, copy) void (^frame_changed_block)(void);

@end
