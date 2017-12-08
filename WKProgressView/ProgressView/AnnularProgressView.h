//
//  AnnularProgressView.h
//  WKProgressView
//
//  Created by 吴珂 on 2017/4/18.
//  Copyright © 2017年 吴珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnnularProgressView : UIView

@property (nonatomic, assign) CGFloat progress;//(0, 1)

@property (nonatomic, strong) UIColor *arcColor;

@property (nonatomic, assign) CGFloat lineWidth;

@end
