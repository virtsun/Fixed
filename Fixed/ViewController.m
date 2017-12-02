//
//  ViewController.m
//  Fixed
//
//  Created by YHL on 2017/11/14.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

#import "ViewController.h"
#import "HFFutureStarViewController.h"
#import "CircleImageView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController ()
@end

@implementation ViewController{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];

    CircleImageView *imageView = [[CircleImageView alloc] init];
    imageView.frame = CGRectMake(30, 100, 320, 160);
    imageView.cornerRadius = 80;
//    imageView.image = [UIImage imageNamed:@"w72I1zv.jpg"];
    imageView.strokeWidth = 2;
    [self.view addSubview:imageView];
    
    NSURL *url = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1512199883512&di=cdb264b783726a7bdb363a3eaba45573&imgtype=0&src=http%3A%2F%2Fwww.pp3.cn%2Fuploads%2F201510%2F2015102204.jpg"];
    
//    imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    
    [imageView sd_setImageWithURL:url
                 placeholderImage:[UIImage imageNamed:@"w72I1zv.jpg"]];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)openFiixable:(id)sender{
    HFFutureStarViewController *star = [[HFFutureStarViewController alloc] init];
    
    [self presentViewController:star animated:YES completion:nil];
}
- (IBAction)tste:(id)sender {
   
}
- (IBAction)openTop:(id)sender{
  
}

@end
