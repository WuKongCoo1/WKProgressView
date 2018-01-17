//
//  WaveProgressView.m
//  WKProgressView
//
//  Created by 吴珂 on 2017/4/18.
//  Copyright © 2017年 吴珂. All rights reserved.
//

#import "WaveProgressView.h"


@interface WaveProgressView ()

@property (nonatomic, assign) CGFloat initialPhase;//初相
@property (nonatomic, strong) CADisplayLink *timer;

@end



//y=Asin(ωx+φ)+k
@implementation WaveProgressView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonSetup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       [self commonSetup];
    }
    return self;
}

- (void)commonSetup
{
    CADisplayLink *timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(moveWave:)];
    [timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *sinPath = [UIBezierPath bezierPath];
    UIBezierPath *cosPath = [UIBezierPath bezierPath];
    CGFloat y;
    CGFloat amplitude = 5;//振幅
    CGFloat palstance = M_PI / self.bounds.size.width;//角速度

    CGPoint startPoint = CGPointMake(0, CGRectGetHeight(rect));
    [sinPath moveToPoint:startPoint];
    [cosPath moveToPoint:startPoint];
    //正弦曲线
    for (CGFloat x = 0.0 ; x <= rect.size.width; x++) {
        y = amplitude * sin(palstance * x + self.initialPhase);
        CGPoint point = CGPointMake(x, y + CGRectGetHeight(rect) * (1 - self.progress) - amplitude);

        [sinPath addLineToPoint:point];
    }
    
    //余弦曲线
    for (int x = 0 ; x <= rect.size.width; x++) {
        y = amplitude * cos(palstance * x + self.initialPhase);
        CGPoint point = CGPointMake(x, y + CGRectGetHeight(rect) * (1 - self.progress) - amplitude);
        
        [cosPath addLineToPoint:point];
    }
    
    
    CGPoint endPoint = CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect));
    [sinPath addLineToPoint:endPoint];
    [cosPath addLineToPoint:endPoint];
    [[UIColor lightGrayColor] setFill];
    
    CGContextAddPath(context, sinPath.CGPath);
    CGContextDrawPath(context, kCGPathFill);
    
    [[UIColor cyanColor] setFill];
    CGContextAddPath(context, cosPath.CGPath);
    CGContextDrawPath(context, kCGPathFill);
}

- (void)moveWave:(CADisplayLink *)timer
{
    self.initialPhase += 0.1;

    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsDisplay];
    });
    
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
}


- (void)dealloc
{
    [self.timer invalidate];
}
@end
