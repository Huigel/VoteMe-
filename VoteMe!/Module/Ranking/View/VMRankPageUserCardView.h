//
//  VMRankPageUserInfoView.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/28.
//

#import "VMBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMRankPageUserCardView : VMBaseView

@property(nonatomic, strong) UILabel *UserNameLabel;

@property(nonatomic, strong) UILabel *UserScoreLabel;

@property(nonatomic, strong) UILabel *UserRankingLabel;

-(instancetype)init;

@end

NS_ASSUME_NONNULL_END
