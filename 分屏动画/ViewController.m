//
//  ViewController.m
//  分屏动画
//
//  Created by 刘浩浩 on 16/8/22.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import "ViewController.h"
#import "ScreenView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ScreenView *screenView = [[ScreenView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) screenImage:[UIImage imageNamed:@"750-1334.png"]];
    [self.view addSubview:screenView];
 

    [screenView screenAnimation];

    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
