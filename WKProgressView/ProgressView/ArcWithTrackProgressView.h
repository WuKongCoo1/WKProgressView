//
//  ArcWithTrackProgressView.h
//  WKProgressView
//
//  Created by 吴珂 on 2017/4/17.
//  Copyright © 2017年 吴珂. All rights reserved.
//  有外面一圈线的进度view

#import <UIKit/UIKit.h>

@interface ArcWithTrackProgressView : UIView

@property (nonatomic, strong) UIColor *trackColor;
@property (nonatomic, strong) UIColor *progressColor;

@property (nonatomic, assign) CGFloat progress;

@end
