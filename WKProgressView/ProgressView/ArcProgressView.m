//
//  ArcProgressView.m
//  WKProgressView
//
//  Created by 吴珂 on 2017/4/17.
//  Copyright © 2017年 吴珂. All rights reserved.
//

#import "ArcProgressView.h"

@implementation ArcProgressView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.arcColor = [UIColor cyanColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();
   
    [self.arcColor setFill];
    
    CGFloat startAngle = -M_PI_2;
    CGFloat endAngle  = self.progress * M_PI * 2 + startAngle;
   
    CGPoint center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:rect.size.width / 2 startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    CGContextAddPath(context, path.CGPath);
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
