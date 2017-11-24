//
//  ViewController.m
//  Fixed
//
//  Created by l.t.zero on 2017/11/14.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

#import "HFFutureStarViewController.h"
#import "HFFiixableScrollView.h"
#import <TYTabPagerController.h>
#import "HFFutureTopView.h"
#import "HFFutureStarAllViewController.h"
#import "UIScrollView+Fiixable.h"
#import <MJRefresh/MJRefresh.h>
#import "HFFutureTipView.h"

@interface HFFutureStarViewController ()
<HFFiixableScrollViewDataSource,
FiixableBaseScrollDelegate,
TYTabPagerControllerDataSource,
TYTabPagerControllerDelegate,
HFFiixableScrollViewDelegate>

@property (nonatomic, strong) HFFutureTopView *topView;
@property (nonatomic, strong) TYTabPagerController *pagerController;
@property (nonatomic, strong) HFFutureStarAllViewController *allVC;
@property (nonatomic, strong) HFFutureTipView *tipView;
@property (nonatomic, strong) UINavigationBar *topbar;
@end

@implementation HFFutureStarViewController{
    HFFiixableScrollView *fii;
}
- (void)back:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = UIColorFromRGB(0x101622);
    
    _topbar = [[UINavigationBar alloc] init];
    _topbar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 80);
    _topbar.backgroundColor = UIColorFromRGBA(arc4random(), 1.f);
    
    [self.view addSubview:_topbar];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(16, 20, 60, 60);
    [back setTitle:@"返回" forState:UIControlStateNormal];
    [back setTitleColor:UIColorFromRGBA(arc4random(), 1.f) forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [_topbar addSubview:back];
    
    fii = [[HFFiixableScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 0)];
    fii.dataSource = self;
    fii.delegate = self;
    fii.safeContentInset = UIEdgeInsetsMake(CGRectGetHeight(_topbar.frame), 0, 0, 0);
    __weak typeof(fii) weak_fii = fii;
    
    fii.scrollView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weak_fii.scrollView.mj_header endRefreshing];
        });
    }];
    
    
    [self.view insertSubview:fii atIndex:0];
}

- (UIView *)headerOfFiixiableScroll{
    if (!_topView){
        _topView = [[HFFutureTopView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200) style:UITableViewStyleGrouped];
        __weak typeof(fii) weak_fii = fii;
        [_topView sizeToFit];
        _topView.frame_changed_block = ^{
            [weak_fii reloadlayout];
        };
    }
    return _topView;
}

- (UIView *)fiixiableOfFiixiableScroll{
    if (!_pagerController){
     _pagerController = [[TYTabPagerController alloc] init];
     _pagerController.tabBar.contentInset = UIEdgeInsetsMake(20, 20, 0, 20);
     [_pagerController setTabBarHeight:0];
     _pagerController.tabBar.layout.selectedTextColor = [UIColor greenColor];
     _pagerController.dataSource = self;
     _pagerController.delegate = self;
     _pagerController.tabBar.layout.adjustContentCellsCenter = NO;
     [_pagerController reloadData];
     
     //        _pagerController.view.backgroundColor = [UIColor purpleColor];
     _pagerController.pagerController.scrollView.relationToFiixable = YES;
     //    [self addChildViewController:_pagerController];
     }
     _pagerController.view.frame = self.view.bounds;
     return _pagerController.view;
     /*
    if (!_allVC){
        _allVC = [[HFFutureStarAllViewController alloc] init];
        _allVC.delegate = self;
    }
    
    _allVC.view.frame = self.view.bounds;
    return _allVC.view;
      */
    
}
- (UIView *)scaleHeaderOfFiixiableScroll{
    if (!_tipView){
        _tipView = [[HFFutureTipView alloc] init];
        _tipView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 150);
        _tipView.maxHeight = 150;
        _tipView.minScaleHeight = [self scaleHeaderMinHeightOfFiixiableScroll];
    }
    
    return _tipView;
}
- (CGFloat)scaleHeaderMinHeightOfFiixiableScroll{
    return 40;
}
- (void)fiixiableScrollView:(HFFiixableScrollView *)scrollView fixed:(BOOL)fixed{
    for (int i = 0; i < [self numberOfControllersInTabPagerController]; i++){
        HFFiixableBaseScrollViewController *vc = (HFFiixableBaseScrollViewController*)[_pagerController.pagerController controllerForIndex:i];
        [vc.collectionView setContentOffset:CGPointZero];
    }
}
- (void)fiixiableScrollView:(HFFiixableScrollView *)scrollView progress:(CGFloat)progress{
//    NSLog(@"%lf", progress);
    self.topbar.alpha = 1-progress;
}
#pragma mark --
#pragma mark -- TYTabPagerController
- (NSInteger)numberOfControllersInTabPagerController{
    return 1;
}
- (UIViewController *)tabPagerController:(TYTabPagerController *)tabPagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching{
     HFFutureStarAllViewController * allVC = [[HFFutureStarAllViewController alloc] init];
     allVC.delegate = self;
    
    return allVC;
}

- (NSString *)tabPagerController:(TYTabPagerController *)tabPagerController titleForIndex:(NSInteger)index{
    return [NSString stringWithFormat:@"测试%ld", index];
}
//TODO:关键设置一定要有
- (void)fiiableCurrentScrollView:(UIScrollView *)scrollview{
    fii.relationScrollView = scrollview;
    [fii.scrollView.panGestureRecognizer requireGestureRecognizerToFail:scrollview.panGestureRecognizer];
    
}
#pragma mark --
#pragma mark -- 控制
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [fii scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [fii scrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [fii scrollViewDidEndDecelerating:scrollView];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [fii scrollViewWillBeginDragging:scrollView];
    
}
@end

