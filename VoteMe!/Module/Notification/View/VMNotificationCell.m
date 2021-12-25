//
//  VMNotificationCell.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/17.
//

#import "VMNotificationCell.h"

@implementation VMNotificationCell

-(instancetype)init{
    self = [super init];
    [self configureH];
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureH{
    
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(12 * HEIGHT_SCALE);
        make.bottom.equalTo(self.contentView).with.offset(-28 * HEIGHT_SCALE);
        make.left.equalTo(self.contentView).with.offset(40 * WIDTH_SCALE);
        make.right.equalTo(self.contentView).with.offset(-40 * WIDTH_SCALE);
    }];
    
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.top.equalTo(self.contentView).with.offset(12 * HEIGHT_SCALE);
        make.bottom.equalTo(self.contentView).with.offset(-11 * HEIGHT_SCALE);
        //make.left.equalTo(self.contentView).with.offset(40 * WIDTH_SCALE);
        make.right.equalTo(self.contentLabel);
    }];
    
//    self.redFlagView.layer.cornerRadius = 4 * WIDTH_SCALE;
//    [self.contentView addSubview:self.redFlagView];
//    [self.redFlagView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView).with.offset(8 * HEIGHT_SCALE);
//        make.right.equalTo(self.contentView).with.offset(-30 * WIDTH_SCALE);
//        make.width.mas_equalTo(8 * WIDTH_SCALE);
//        make.height.mas_equalTo(8 * WIDTH_SCALE);
//    }];
    
    [self.contentView addSubview:self.seperaterView];
    [self.seperaterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.right.equalTo(self.contentView).with.offset(-40 * WIDTH_SCALE);
        make.left.equalTo(self.contentView).with.offset(40 * WIDTH_SCALE);
        make.height.mas_equalTo(0.4 * HEIGHT_SCALE);
    }];
    
}

#pragma mark - lazy load
-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _contentLabel.font = [UIFont systemFontOfSize:10 * HEIGHT_SCALE];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

-(UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor colorWithHexString:@"#CDD0CB"];
        _timeLabel.font = [UIFont systemFontOfSize:6 * HEIGHT_SCALE];
        _timeLabel.numberOfLines = 1;
    }
    return _timeLabel;
}

-(UIView *)redFlagView{
    if(!_redFlagView){
        _redFlagView = [[UILabel alloc] init];
        _redFlagView.backgroundColor = [UIColor redColor];
    }
    return _redFlagView;
}
-(UIView *)seperaterView{
    if(!_seperaterView){
        _seperaterView = [[UILabel alloc] init];
        _seperaterView.backgroundColor = [UIColor colorWithHexString:@"#CDD0CB"];
    }
    return _seperaterView;
}


@end
