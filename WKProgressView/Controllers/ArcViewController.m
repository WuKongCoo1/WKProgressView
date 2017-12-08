//
//  ArcViewController.m
//  WKProgressView
//
//  Created by 吴珂 on 2017/4/17.
//  Copyright © 2017年 吴珂. All rights reserved.
//

#import "ArcViewController.h"
#import "ArcProgressView.h"

@interface ArcViewController ()

@property (weak, nonatomic) IBOutlet ArcProgressView *progressView;
- (IBAction)slider:(UISlider *)sender;

@end

@implementation ArcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)slider:(UISlider *)sender {
    _progressView.progress = sender.value;
//    [_progressView setNeedsDisplay];
}

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}
@end
