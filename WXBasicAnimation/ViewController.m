//
//  ViewController.m
//  WXTransitionDemo
//
//  Created by BlackEr Gray on 17/7/17.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

#import "ViewController.h"
#import "WXLogInAnimationController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)NSArray *vcName;
@end

@implementation ViewController

- (NSArray *)vcName {
    if (!_vcName) {
        _vcName = @[@"WXLogInAnimationController",@"WXTransitonAnimation",@"WXSpringAnimation",@"WX_CABasicAnimation",@"WX_CAKeyFrameAnimation",@"WX_CATransiton"];
    }
    return  _vcName;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"logoAnimation",@"TransitionAnimation",@"springAnimation",@"WX_CABasicAnimation基础动画",@"WX_CAKeyFrameAnimation帧动画",@"WX_CATransiton转场动画"].mutableCopy;
        
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];

    

}

- (void)setupTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview: self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)
    indexPath {
    UIViewController *vc = (UIViewController *)[NSClassFromString(self.vcName[indexPath.row]) new];
    vc.title = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];

    return cell;
    
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

@end
