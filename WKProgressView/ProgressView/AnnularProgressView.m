//
//  AnnularProgressView.m
//  WKProgressView
//
//  Created by 吴珂 on 2017/4/18.
//  Copyright © 2017年 吴珂. All rights reserved.
//

#import "AnnularProgressView.h"

@interface AnnularProgressView()

@property (nonatomic, strong) CAShapeLayer *tick;

@end

@implementation AnnularProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonSetup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonSetup];
    }
    return self;
}

- (void)commonSetup
{
    self.arcColor = [UIColor cyanColor];
    self.lineWidth = 5.f;
    
    //设置shapeLayer
    CAShapeLayer *tick = [[CAShapeLayer alloc] init];
    tick.bounds = self.bounds;
    tick.position = CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2);
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(width * 0.25, height * 0.46)];
    [bezierPath addLineToPoint:CGPointMake(width * 0.45, height * 0.71)];
    [bezierPath addLineToPoint:CGPointMake(width * 0.78, height * 0.29)];
    tick.path = bezierPath.CGPath;
    tick.fillColor = [UIColor clearColor].CGColor;
    tick.strokeColor = [UIColor cyanColor].CGColor;
    tick.strokeStart = 0;
    tick.strokeEnd = 0;
    tick.lineWidth = self.lineWidth;
    tick.lineCap = kCALineJoinRound;
    
    [self.layer addSublayer:tick];
    
    self.tick = tick;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, self.lineWidth);
    
    [self.arcColor setStroke];
    
    //绘制圆环
    CGFloat startAngle = -M_PI_2;
    CGFloat endAngle  = self.progress * M_PI * 2 + startAngle;
    CGPoint center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:rect.size.width / 2 - self.lineWidth startAngle:startAngle endAngle:endAngle clockwise:YES];
    CGContextAddPath(context, path.CGPath);
    CGContextDrawPath(context, kCGPathStroke);
    
    self.tick.strokeEnd = self.progress;//设置勾的进度
    
}

- (void)setProgress:(CGFloat)progress
{
    NSLog(@"%g", progress);
    if (progress > 1) {
        progress = 1;
    }else if (progress < 0){
        progress = 0;
    }
    _progress = progress;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsDisplay];
    });
}

@end
