//
//  ScreenView.m
//  分屏动画
//
//  Created by 刘浩浩 on 16/8/22.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import "ScreenView.h"

@implementation ScreenView


- (id)initWithFrame:(CGRect)frame screenImage:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        _topLayer = [CALayer layer];
        _downLayer = [CALayer layer];
        self.screenImage = image;
        [self drawTopShapeLayer];
        [self drawDownShapeLayer];
    }
    return self;
}

- (void)screenAnimation
{
    //创建一个CABasicAnimation作用于CALayer的anchorPoint
    CABasicAnimation *topAnimation = [CABasicAnimation animationWithKeyPath:@"anchorPoint"];
    //设置移动路径
    topAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    //动画时间
    topAnimation.duration = 1.5;
    //设置代理，方便完成动画后移除当前view
    topAnimation.delegate = self;
    //设置动画速度为匀速
    topAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //设置动画结束后不移除
    topAnimation.removedOnCompletion = NO;
    //动画结束后保持结束状态
    topAnimation.fillMode = kCAFillModeForwards;
    [_topLayer addAnimation:topAnimation forKey:@"topAnimation"];
    
    //创建一个CABasicAnimation作用于CALayer的anchorPoint
    CABasicAnimation *downAnimation = [CABasicAnimation animationWithKeyPath:@"anchorPoint"];
    //设置移动路径
    downAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    //动画时间
    downAnimation.duration = 1.5;
    //设置动画速度为匀速
    downAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //设置动画结束后不移除
    downAnimation.removedOnCompletion = NO;
    //动画结束后保持结束状态
    downAnimation.fillMode = kCAFillModeForwards;
    [_downLayer addAnimation:downAnimation forKey:@"downAnimation"];

}

- (void)drawTopShapeLayer
{
    //绘制贝赛尔曲线
    UIBezierPath *topBezier = [[UIBezierPath alloc]init];
    [topBezier moveToPoint:CGPointMake(0, 0)];
    [topBezier addLineToPoint:CGPointMake(self.bounds.size.width, 0)];
    [topBezier addCurveToPoint:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0) controlPoint1:CGPointMake(self.bounds.size.width, 0) controlPoint2:CGPointMake(self.bounds.size.width/3*2+70, self.bounds.size.height/3+70)];
    [topBezier addCurveToPoint:CGPointMake(0, self.bounds.size.height) controlPoint1:CGPointMake(self.bounds.size.width/3-70, self.bounds.size.height/3*2-70) controlPoint2:CGPointMake(0, self.bounds.size.height)];
    [topBezier addLineToPoint:CGPointMake(0, 0)];
    [topBezier closePath];
    //创建一个CAShapeLayer，得到贝赛尔曲线的路径
    CAShapeLayer *topShape = [CAShapeLayer layer];
    topShape.path = topBezier.CGPath;
    //给_topLayer设置contents图
    _topLayer.contents = (__bridge id _Nullable)(_screenImage.CGImage);
    _topLayer.frame = self.frame;
    [self.layer addSublayer:_topLayer];
    //截取上面shape上的图片内容
    _topLayer.mask = topShape;

}

- (void)drawDownShapeLayer
{
    //绘制贝赛尔曲线
    UIBezierPath *downBezier = [[UIBezierPath alloc]init];
    [downBezier moveToPoint:CGPointMake(self.bounds.size.width, 0)];
    [downBezier addCurveToPoint:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0) controlPoint1:CGPointMake(self.bounds.size.width, 0) controlPoint2:CGPointMake(self.bounds.size.width/3*2+70, self.bounds.size.height/3+70)];
    [downBezier addCurveToPoint:CGPointMake(0, self.bounds.size.height) controlPoint1:CGPointMake(self.bounds.size.width/3-70, self.bounds.size.height/3*2-70) controlPoint2:CGPointMake(0, self.bounds.size.height)];
    [downBezier addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];

    [downBezier addLineToPoint:CGPointMake(self.bounds.size.width, 0)];
    [downBezier closePath];
    //创建一个CAShapeLayer，得到贝赛尔曲线的路径
    CAShapeLayer *downShape = [CAShapeLayer layer];
    downShape.path = downBezier.CGPath;
    //给_downLayer设置contents图
    _downLayer.contents = (__bridge id _Nullable)(_screenImage.CGImage);
    _downLayer.frame = self.frame;
    [self.layer addSublayer:_downLayer];
    //截取下面shape上的图片内容
    _downLayer.mask = downShape;

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        //动画结束后删除内容图片
        [self removeFromSuperview];
    }
}


@end
