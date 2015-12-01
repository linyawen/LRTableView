//
//  ViewController.m
//  LoadingRetryTableView
//
//  Created by Lin Yawen on 15/12/1.
//  Copyright (c) 2015年 ND_XM_LinYaWen. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+LoadingRetry.h"

@interface ViewController ()
@property(nonatomic,retain)NSMutableArray * datas;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak ViewController * weakSelf = self;
    [self.tableView.retryView setOnRetryBlock:^(id<IRetryView> view) {
        [weakSelf loadData];
    }];
    UIBarButtonItem * btnFrefresh = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(loadData)];
    self.navigationItem.rightBarButtonItem = btnFrefresh;
    self.datas = [NSMutableArray array];
    
}

-(void)loadData
{
    //测试加载数据正常的情况
    [self mock_loadDataSucc];
    //测试加载数据失败的情况
    [self mock_loadDataError];
}

-(void)mock_loadDataSucc
{
    [self.datas  removeAllObjects];
    [self.tableView reload_begin];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //1, api end succ
        NSInteger datacount = 0;
        //        datacount = 3; // Comment this line to show empty View
        for (NSInteger i = 0 ; i < datacount; i ++) {
            [self.datas addObject:[NSObject new]];
        };
        [self.tableView reload_end];
    });
}

-(void)mock_loadDataError
{
    //2,api end error
    [self.datas  removeAllObjects];
    [self.tableView reload_begin];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reload_error];
    });
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
};

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"data : %ld",indexPath.row];

    return cell;
    
    
}
@end
