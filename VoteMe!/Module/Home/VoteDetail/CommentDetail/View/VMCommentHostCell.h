//
//  VMCommentHostCell.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/6.
//

#import "VMBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMCommentHostCell : VMBaseTableViewCell

@property(nonatomic, strong) UIView *cardBackgroundView;

@property(nonatomic, strong) UILabel *createrNameLabel;

@property(nonatomic, strong) UILabel *timeLabel;

@property(nonatomic, strong) UILabel *contentLabel;

@property(nonatomic, strong) UIImageView *contentImageView;


-(instancetype)init;

@end

NS_ASSUME_NONNULL_END
