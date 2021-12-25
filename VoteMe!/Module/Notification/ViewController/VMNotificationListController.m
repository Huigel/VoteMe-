//
//  VMNotificationListController.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/17.
//

#import "VMNotificationListController.h"

static NSString *const systemNotificationCellIdentifier  = @"systemNotificationCellIdentifier";
static NSString *const notificationCellIdentifier  = @"notificationCellIdentifier";

@interface VMNotificationListController ()

@end

@implementation VMNotificationListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBarView.backBtn.hidden = false;
    self.navigationBarView.title.text = @"通知";
    
    [self configureHierachy]
    ;}

-(void)viewWillAppear:(BOOL)animated{
    
    [self updateNotificationPullDown];
    
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}

-(void)configureHierachy{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.navigationBarView.mas_bottom);
    }];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:TRUE];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VMNotificationCell *cell = [[VMNotificationCell alloc] init];
    
    [VMCellConfigure configureNotificationCell:cell model:self.modelArray[indexPath.row]];
    
    if(indexPath.row == 0){
        cell.seperaterView.hidden = true;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

#pragma mark - SEL
-(void)updateNotificationPullDown{
    [self updateNotificationWithFlag:VMRefresh];
}

-(void)updateNotificationDragUp{
    [self updateNotificationWithFlag:VMLoadMore];
}


-(void)updateNotificationWithFlag:(VMResponseFlag)flag{
    [VMWebManager shareInstance].delegate = self;
    
    if(flag == VMRefresh){
        NSString *orderBy = @"created_at";
        [VMWebManager shareInstance].delegate = self;
        [[VMWebManager shareInstance]getNotificationWithAfter:0];
    }else{
        NSString *orderBy = @"created_at";
        [VMWebManager shareInstance].delegate = self;
        [[VMWebManager shareInstance] getNotificationWithAfter:0];
    }
}


#pragma mark - 网络回调
-(void)handleNotificationWithResponse:(_Nullable id)response success:(BOOL)success{
    
    [self.modelArray removeAllObjects];
    
    if(success){
        if(response){
            for (NSDictionary *dict in (NSArray *) response) {
                VMNotificationModel *model = [VMNotificationModel yy_modelWithDictionary:dict];
                [self.modelArray addObject:model];
            }
            [self.tableView reloadData];
        }
    }
    if(self.tableView.mj_header.isRefreshing) [self.tableView.mj_header endRefreshing];
    if(self.tableView.mj_footer.isRefreshing) [self.tableView.mj_footer endRefreshing];
}

#pragma mark -lazy load
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:VMSystemNotificationCell.class  forCellReuseIdentifier:systemNotificationCellIdentifier];
        [_tableView registerClass:VMNotificationCell.class forCellReuseIdentifier:notificationCellIdentifier];
        
        _tableView.backgroundColor = [UIColor colorWithHexString:kVMBackgroundColor];
        _tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateNotificationPullDown)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //_tableView.estimatedRowHeight = 300;
        //_tableView.rowHeight = UITableViewAutomaticDimension;
        //_tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(updateCommentDragUp)];
    }
    return _tableView;
}

-(NSMutableArray<VMNotificationModel *> *)modelArray{
    if(!_modelArray){
        _modelArray = [[NSMutableArray<VMNotificationModel *> alloc] init];
    }
    return _modelArray;
}

@end
