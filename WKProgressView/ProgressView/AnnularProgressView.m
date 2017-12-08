//
//  AnnularProgressView.m
//  WKProgressView
//
//  Created by 吴珂 on 2017/4/18.
//  Copyright © 2017年 吴珂. All rights reserved.
//

#import "AnnularProgressView.h"

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
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, self.lineWidth);
    
    [self.arcColor setStroke];
    
    CGFloat startAngle = -M_PI_2;
    CGFloat endAngle  = self.progress * M_PI * 2 + startAngle;
    
    CGPoint center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:rect.size.width / 2 - self.lineWidth startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    CGContextAddPath(context, path.CGPath);
    
    CGContextDrawPath(context, kCGPathStroke);
    
    //绘制勾
    
    CGMutablePathRef tickPath = CGPathCreateMutable();
    CGPathMoveToPoint(tickPath, NULL, 5, 50);
    CGPathAddLineToPoint(tickPath, NULL, 70, 100);
    CGPathAddLineToPoint(tickPath, NULL, 150, 5);
    CGContextAddPath(context, tickPath);
    
    CGPathRelease(tickPath);
    
    CGContextDrawPath(context, kCGPathStroke);
    
    
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
