//
//  VMRankPageUserInfoView.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/28.
//

#import "VMRankPageUserCardView.h"

@implementation VMRankPageUserCardView

-(instancetype)init{
    self = [super init];
    self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.layer.cornerRadius = 10 * WIDTH_SCALE;
    
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0 * WIDTH_SCALE, 2 * HEIGHT_SCALE);
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowRadius = 3 * WIDTH_SCALE;
    
    UILabel *hiLabel = [[UILabel alloc] init];
    hiLabel.text = @"Hi,";
    hiLabel.textColor = [UIColor colorWithHexString:@"#191D21"];
    hiLabel.font = [UIFont systemFontOfSize:(18 * WIDTH_SCALE)];
    
    self.UserNameLabel.text = @"用户ID";
    self.UserScoreLabel.text = @"你的积分为：";
    self.UserRankingLabel.text = @"排名是：";
    
    [self addSubview:hiLabel];
    [hiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(12 * HEIGHT_SCALE);
        make.left.equalTo(self).with.offset(20 * WIDTH_SCALE);
        make.height.mas_equalTo(23 * HEIGHT_SCALE);
    }];
    
    [self addSubview:self.UserNameLabel];
    [self.UserNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hiLabel);
        make.left.equalTo(hiLabel.mas_right);
        make.height.mas_equalTo(23 * HEIGHT_SCALE);
    }];
    
    [self addSubview:self.UserScoreLabel];
    [self.UserScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(43 * HEIGHT_SCALE);
        make.left.equalTo(hiLabel);
        make.height.mas_equalTo(20 * HEIGHT_SCALE);
    }];
    
    [self addSubview:self.UserRankingLabel];
    [self.UserRankingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.UserScoreLabel.mas_bottom);
        make.left.equalTo(hiLabel);
        make.height.mas_equalTo(20 * HEIGHT_SCALE);
    }];
    
    UIImageView *pictureImageView = [[UIImageView alloc] init];
    pictureImageView.image = [UIImage imageNamed:@"RankingUserCardImage"];
    [self addSubview:pictureImageView];
    [pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.right.equalTo(self).with.offset(-7 * WIDTH_SCALE);
        make.height.mas_equalTo(93 * HEIGHT_SCALE);
        make.width.mas_equalTo(106 * WIDTH_SCALE);
    }];
    
    return self;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - lazy load
-(UILabel *)UserNameLabel{
    if(!_UserNameLabel){
        _UserNameLabel = [[UILabel alloc] init];
        _UserNameLabel.textColor = [UIColor colorWithHexString:@"#191D21"];
        _UserNameLabel.font = [UIFont boldSystemFontOfSize:(18 * WIDTH_SCALE)];
    }
    return _UserNameLabel;
}

-(UILabel *)UserScoreLabel{
    if(!_UserScoreLabel){
        _UserScoreLabel = [[UILabel alloc] init];
        _UserScoreLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _UserScoreLabel.font = [UIFont systemFontOfSize:(14 * WIDTH_SCALE)];
    }
    return _UserScoreLabel;
}

-(UILabel *)UserRankingLabel{
    if(!_UserRankingLabel){
        _UserRankingLabel = [[UILabel alloc] init];
        _UserRankingLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _UserRankingLabel.font = [UIFont systemFontOfSize:(14 * WIDTH_SCALE)];
    }
    return _UserRankingLabel;
}

@end
