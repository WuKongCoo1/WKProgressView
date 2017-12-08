//
//  WaveProgressView.m
//  WKProgressView
//
//  Created by 吴珂 on 2017/4/18.
//  Copyright © 2017年 吴珂. All rights reserved.
//

#import "WaveProgressView.h"
#import "SVRadialGradientLayer.h"


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
    
    SVRadialGradientLayer *layer = [SVRadialGradientLayer layer];
    layer.gradientCenter = self.center;
    layer.frame = self.bounds;
    self.backgroundColor = [UIColor clearColor];
    [self.layer addSublayer:layer];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *sinPath = [UIBezierPath bezierPath];
    UIBezierPath *cosPath = [UIBezierPath bezierPath];
    CGFloat y;
    CGFloat amplitude = 5;//振幅
    CGFloat palstance = M_PI/self.bounds.size.width;//角速度

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
    
    CGPoint point = CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetWidth(self.bounds) / 2);
    
    size_t locationsCount = 2;
    CGFloat locations[2] = {0.0f, 1.0f};
    CGFloat colors[8] = {0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.75f};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, locations, locationsCount);
    CGColorSpaceRelease(colorSpace);
    
    float radius = MIN(self.bounds.size.width , self.bounds.size.height);
    CGContextDrawRadialGradient (context, gradient, point, 0, point, radius, kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradient);
//
    //使用rgb颜色空间
//    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
//    
//    /*指定渐变色
//     space:颜色空间
//     components:颜色数组,注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色（red、green、blue、alpha），
//     如果有三个颜色则这个数组有4*3个元素
//     locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
//     count:渐变个数，等于locations的个数
//     */
//    CGFloat compoents[12]={
//        248.0/255.0,86.0/255.0,86.0/255.0,1,
//        249.0/255.0,127.0/255.0,127.0/255.0,1,
//        1.0,1.0,1.0,1.0
//    };
//    CGFloat locations[3]={0,0.3,1.0};
//    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 3);
//    
//    /*绘制径向渐变
//     context:图形上下文
//     gradient:渐变色
//     startCenter:起始点位置
//     startRadius:起始半径（通常为0，否则在此半径范围内容无任何填充）
//     endCenter:终点位置（通常和起始点相同，否则会有偏移）
//     endRadius:终点半径（也就是渐变的扩散长度）
//     options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，但是到结束位置之后不再绘制，
//     kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，但到结束点之后继续填充
//     */
//    
//    CGContextDrawRadialGradient(context, gradient, point,5, point, 50, kCGGradientDrawsAfterEndLocation);
//    //释放颜色空间
//    CGColorSpaceRelease(colorSpace);
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
