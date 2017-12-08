//
//  ArcWithTrackProgressView.m
//  WKProgressView
//
//  Created by 吴珂 on 2017/4/17.
//  Copyright © 2017年 吴珂. All rights reserved.
//

#import "ArcWithTrackProgressView.h"

@interface ArcWithTrackProgressView ()

@end

@implementation ArcWithTrackProgressView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.trackColor = [UIColor cyanColor];
        self.progressColor = [UIColor cyanColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //绘制圈
    UIBezierPath *trackPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(rect, 2, 2)];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5);
    CGContextAddPath(context, trackPath.CGPath);
    CGContextSaveGState(context);
    [self.trackColor setStroke];
    
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextRestoreGState(context);
    //绘制进度
    [self.progressColor setFill];
    CGFloat startAngle = - M_PI_2;
    CGFloat endAngle = self.progress * 2 * M_PI + startAngle;
    CGPoint center = CGPointMake(CGRectGetWidth(rect) / 2, CGRectGetHeight(rect) / 2);
    CGFloat radius = CGRectGetHeight(rect) / 2 - 4;
    UIBezierPath *progressPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    CGContextAddPath(context, progressPath.CGPath);
    CGContextAddLineToPoint(context, center.x, center.y);
    CGContextDrawPath(context, kCGPathFill);
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
