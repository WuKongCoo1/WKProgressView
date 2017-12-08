//
//  ViewController.m
//  WKProgressView
//
//  Created by 吴珂 on 2017/4/17.
//  Copyright © 2017年 吴珂. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = @[
                        @{@"ArcProgress" : @"ArcViewController"},
                        @{@"ArcWithTrackProgress" : @"ArcWithTrackViewController"},
                        @{@"AnnularProgress" : @"AnnularViewController"},
                        @{@"WaveProgress" : @"WaveViewController"}
                          ];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.dataSource[indexPath.row];
    
    NSString *title = [dict.allKeys firstObject];
    cell.textLabel.text = title;
}

#pragma mark - UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.dataSource[indexPath.row];
    UIViewController *vc =  ({
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        id vc = [sb instantiateViewControllerWithIdentifier:[dict.allValues firstObject]];
        vc;
    });
    
    if (vc) {
        
        [self.navigationController pushViewController:vc animated:YES];
    }

}


@end
