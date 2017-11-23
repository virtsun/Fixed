//
//  ViewController.m
//  Fixed
//
//  Created by YHL on 2017/11/14.
//  Copyright © 2017年 l.t.zero. All rights reserved.
//

#import "ViewController.h"
#import "HFFutureStarViewController.h"

@interface ViewController ()
@end

@implementation ViewController{
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
    HFFutureStarViewController *star = [[HFFutureStarViewController alloc] init];
    
    [self presentViewController:star animated:YES completion:nil];
}
- (IBAction)tste:(id)sender {
   
}
- (IBAction)openTop:(id)sender{
  
}

@end
