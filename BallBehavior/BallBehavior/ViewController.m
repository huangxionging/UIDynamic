//
//  ViewController.m
//  BallBehavior
//
//  Created by huangxiong on 7/22/15.
//  Copyright (c) 2015 New_Life. All rights reserved.
//

#import "ViewController.h"
#import "AnimatorViewController.h"




@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSArray *categoryArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _categoryArray = @[@"Gravity", @"Collision", @"Attachment", @"Snap", @"Push"];
    
    _mainTableView = [[UITableView alloc] initWithFrame: self.view.bounds style: UITableViewStylePlain];
    [self.view addSubview: _mainTableView];
    
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _categoryArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = _categoryArray[indexPath.row];

    return cell;
}

#pragma mark---UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AnimatorViewController *animatorViewController = [[AnimatorViewController alloc] init];
    animatorViewController.animatorType = indexPath.row;
    [self.navigationController pushViewController: animatorViewController animated: YES];
}

@end
