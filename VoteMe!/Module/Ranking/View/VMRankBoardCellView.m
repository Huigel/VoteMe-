//
//  VMRankingBoardCellView.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/28.
//

#import "VMRankBoardCellView.h"

@implementation VMRankBoardCellView

-(instancetype)initWithName:(NSString *)userName rank:(NSInteger)userRank score:(NSInteger)userScore{
    self = [super init];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(287 * WIDTH_SCALE);
        make.height.mas_equalTo(50 * HEIGHT_SCALE);
    }];
    
    [self addSubview:self.rankAndNameLabel];
    [self.rankAndNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(5 * WIDTH_SCALE);
        make.height.mas_equalTo(16 * HEIGHT_SCALE);
    }];
    
    [self addSubview:self.scoreLabel];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).with.offset(-8 * WIDTH_SCALE);
        make.height.mas_equalTo(16 * HEIGHT_SCALE);
    }];
    
    UIView *bottomBarView = [[UIView alloc] init];
    bottomBarView.backgroundColor = [UIColor colorWithHexString:@"#CDD0CB"];
    [self addSubview:bottomBarView];
    [bottomBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5 * HEIGHT_SCALE);
    }];
    
    if(userRank >= 1 && userRank <= 3){
        [self addSubview:self.medalImageView];
        [self.medalImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.rankAndNameLabel);
            make.left.equalTo(self.rankAndNameLabel.mas_right).with.offset(5 * WIDTH_SCALE);
            make.width.mas_equalTo(16 * WIDTH_SCALE);
            make.height.mas_equalTo(16 * HEIGHT_SCALE);
        }];
        
        self.rankAndNameLabel.font = [UIFont boldSystemFontOfSize:(14 * WIDTH_SCALE)];
        self.scoreLabel.font = [UIFont boldSystemFontOfSize:(14 * WIDTH_SCALE)];
        
        switch (userRank) {
            case 1:
                self.medalImageView.image = [UIImage imageNamed:@"NO.1medalImage"];
                break;
                
            case 2:
                self.medalImageView.image = [UIImage imageNamed:@"NO.2medalImage"];
                break;
                
            case 3:
                self.medalImageView.image = [UIImage imageNamed:@"NO.3medalImage"];
                break;
                
            default:
                break;
        }
    }else{
        self.rankAndNameLabel.font = [UIFont systemFontOfSize:(12 * WIDTH_SCALE)];
        self.scoreLabel.font = [UIFont systemFontOfSize:(14 * WIDTH_SCALE)];
    }
    
    self.rankAndNameLabel.text = [NSString stringWithFormat:@"%ld.  %@",(long)userRank,userName];
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld分",(long)userScore];
    
    return self;
}



#pragma mark - lazy load
-(UILabel *)rankAndNameLabel{
    if(!_rankAndNameLabel){
        _rankAndNameLabel = [[UILabel alloc] init];
        
    }
    return _rankAndNameLabel;
}

-(UIImageView *)medalImageView{
    if(!_medalImageView){
        _medalImageView = [[UIImageView alloc] init];
        
    }
    return _medalImageView;
}

-(UILabel *)scoreLabel{
    if(!_scoreLabel){
        _scoreLabel = [[UILabel alloc] init];
        
    }
    return _scoreLabel;
}

@end
