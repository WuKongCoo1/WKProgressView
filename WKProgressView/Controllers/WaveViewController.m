//
//  WaveViewController.m
//  WKProgressView
//
//  Created by 吴珂 on 2017/4/18.
//  Copyright © 2017年 吴珂. All rights reserved.
//

#import "WaveViewController.h"
#import "WaveProgressView.h"

@interface WaveViewController ()
@property (weak, nonatomic) IBOutlet WaveProgressView *progressView;
- (IBAction)slideAction:(UISlider *)sender;

@end

@implementation WaveViewController

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

- (IBAction)slideAction:(UISlider *)sender {
    _progressView.progress = sender.value;
}
@end
