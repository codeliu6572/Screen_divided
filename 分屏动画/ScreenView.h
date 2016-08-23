//
//  ScreenView.h
//  分屏动画
//
//  Created by 刘浩浩 on 16/8/22.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScreenView : UIView

@property(nonatomic,strong)CALayer *topLayer;
@property(nonatomic,strong)CALayer *downLayer;
@property(nonatomic,strong)UIImage *screenImage;

- (id)initWithFrame:(CGRect)frame screenImage:(UIImage *)image;


- (void)screenAnimation;

@end
