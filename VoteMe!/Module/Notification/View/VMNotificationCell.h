//
//  VMNotificationCell.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/17.
//

#import "VMBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMNotificationCell : VMBaseTableViewCell

@property(nonatomic, strong) UILabel *contentLabel;

@property(nonatomic, strong) UILabel *timeLabel;

@property(nonatomic, strong) UIView *redFlagView;

@property(nonatomic, strong) UIView *seperaterView;

@property(nonatomic, assign) NSInteger vote_id;

-(instancetype)init;

@end

NS_ASSUME_NONNULL_END
