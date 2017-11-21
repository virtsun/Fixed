//
//  ViewController.m
//  Fixed
//
//  Created by YHL on 2017/11/14.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

#import "ViewController.h"
#import "HFFiixableScrollViewController.h"
#import <TYTabPagerController.h>
#import "HFFiixableTopView.h"
#import "HFFiixableBaseScrollViewController.h"
#import "UIScrollView+Fiixable.h"
#import <MJRefresh/MJRefresh.h>
#import "HFLoopBannerView.h"

@interface ViewController ()
<HFFiixableScrollViewDataSource,
UIScrollViewDelegate,
TYTabPagerControllerDataSource,
TYTabPagerControllerDelegate,
HFFiixableScrollViewDelegate,
HFLoopBannerDataSource>

@property (nonatomic, strong) HFFiixableTopView *topView;
@property (nonatomic, strong) TYTabPagerController *pagerController;
@end

@implementation ViewController{
    HFFiixableScrollViewController *fii;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)openFiixable:(id)sender{
    fii = [HFFiixableScrollViewController new];
    fii.dataSource = self;
    fii.delegate = self;
    
    __weak typeof(fii) weak_fii = fii;

    fii.scrollView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weak_fii.scrollView.mj_header endRefreshing];
        });
    }];
    
    
    [self.navigationController pushViewController:fii animated:YES];
}
- (IBAction)tste:(id)sender {
    HFLoopBannerView *banner = [[HFLoopBannerView alloc] initWithFrame:self.view.bounds];
    
    [banner registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"eeee"];
    
    banner.dataSource = self;
    
    
    [self.view addSubview:banner];
}
- (IBAction)openTop:(id)sender{
  
}
- (NSInteger)numberOfBannerCount{
    return 6;
}
- (CGSize)sizeOfBanner{
    return CGSizeMake(300, CGRectGetHeight(self.view.bounds) * 0.8);
}
- (UICollectionViewCell *)bannerView:(HFLoopBannerView *)bannerView
                            ReusableView:(UICollectionViewCell *)reusableView
                                 atIndex:(NSInteger)index{
    
    UILabel *label = [reusableView viewWithTag:(NSInteger)@"tag"];
    if (!label){
        label = [[UILabel alloc] initWithFrame:reusableView.bounds];
        label.textColor = UIColorFromRGB(arc4random());
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = (NSInteger)@"tag";
        [reusableView addSubview:label];
    }
    label.text = [NSString stringWithFormat:@"%lu",index];
    
    reusableView.backgroundColor = UIColorFromRGB(0xff0000);
    reusableView.layer.cornerRadius = 10;
    reusableView.layer.shadowColor = UIColorFromRGB(arc4random()).CGColor;
    reusableView.layer.shadowOpacity = 1.f;
    reusableView.layer.shadowOffset = CGSizeMake(1, 1);
    
    return reusableView;
}
- (UIView *)headerOfFiixiableScroll{
    if (!_topView){
        _topView = [[HFFiixableTopView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200) style:UITableViewStyleGrouped];
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
        [_pagerController setTabBarHeight:44];
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
}
- (void)fiixiable:(BOOL)fixed{
    for (int i = 0; i < [self numberOfControllersInTabPagerController]; i++){
        HFFiixableBaseScrollViewController *vc = (HFFiixableBaseScrollViewController*)[_pagerController.pagerController controllerForIndex:i];
        [vc.collectionView setContentOffset:CGPointZero];
    }
}
#pragma mark --
#pragma mark -- TYTabPagerController
- (NSInteger)numberOfControllersInTabPagerController{
    return 3;
}
- (UIViewController *)tabPagerController:(TYTabPagerController *)tabPagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching{
    HFFiixableBaseScrollViewController *vc = [HFFiixableBaseScrollViewController new];
    vc.delegate = self;
    return vc;
}

- (NSString *)tabPagerController:(TYTabPagerController *)tabPagerController titleForIndex:(NSInteger)index{
    return [NSString stringWithFormat:@"测试%ld", index];
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
