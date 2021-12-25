//
//  VMNotificationListController.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/17.
//

#import "VMBaseViewController.h"
#import "VMSystemNotificationCell.h"
#import "VMNotificationCell.h"
#import "VMNotificationModel.h"
#import "VMCellConfigure.h"
#import "MJRefresh.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMNotificationListController : VMBaseViewController

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSMutableArray<VMNotificationModel *> *modelArray;

@end

NS_ASSUME_NONNULL_END
