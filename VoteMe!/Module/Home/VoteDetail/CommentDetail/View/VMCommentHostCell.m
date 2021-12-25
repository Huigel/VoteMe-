//
//  VMCommentHostCell.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/6.
//

#import "VMCommentHostCell.h"

@implementation VMCommentHostCell

-(instancetype)init{
    self = [super init];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor colorWithHexString:kVMBackgroundColor];
    
    [self configureHierachy];
    
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

-(void)configureHierachy{
    
    self.createrNameLabel.text = @"诸葛亮";
    self.timeLabel.text = @"猪年狗月";
    self.contentLabel.text = @"这里是详情这里是详情这里是详情";
    
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(UIScreen.mainScreen.bounds.size.width);
//        make.height.mas_equalTo(300 * HEIGHT_SCALE).priority(1000);
//    }];
    
    [self.contentView addSubview:self.cardBackgroundView];
    [self.cardBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(22 * WIDTH_SCALE);
        make.right.equalTo(self.contentView).with.offset(-22 * WIDTH_SCALE);
        make.top.equalTo(self.contentView).with.offset(10 * HEIGHT_SCALE);
        make.bottom.equalTo(self.contentView).with.offset(-20 * HEIGHT_SCALE);
        //make.height.mas_equalTo(200 * HEIGHT_SCALE);
        
    }];
    
    [self.cardBackgroundView addSubview:self.createrNameLabel];
    [self.createrNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cardBackgroundView).with.offset(12 * WIDTH_SCALE);
        make.top.equalTo(self.cardBackgroundView).with.offset(10 * HEIGHT_SCALE);
        make.height.mas_equalTo(12 * HEIGHT_SCALE);
    }];
    
    [self.cardBackgroundView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.createrNameLabel.mas_right).with.offset(10 * WIDTH_SCALE);
        make.centerY.equalTo(self.createrNameLabel);
        make.height.mas_equalTo(12 * HEIGHT_SCALE);
    }];
    
    [self.cardBackgroundView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cardBackgroundView).with.offset(40 * HEIGHT_SCALE);
        make.left.equalTo(self.cardBackgroundView).with.offset(10 * WIDTH_SCALE);
        make.right.equalTo(self.cardBackgroundView).with.offset(-10 * WIDTH_SCALE);
        //make.bottom.equalTo(self.cardBackgroundView).with.offset(-12 * HEIGHT_SCALE);
        //make.height.mas_equalTo(20 * HEIGHT_SCALE);
    }];
    
    
}

#pragma mark - lazy load
-(UIView *)cardBackgroundView{
    if(!_cardBackgroundView){
        _cardBackgroundView = [[UIView alloc] init];
        _cardBackgroundView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        //_cardBackgroundView.backgroundColor = [UIColor redColor];
        _cardBackgroundView.layer.cornerRadius = 12 * WIDTH_SCALE;
        
        [UIView configureShadow:_cardBackgroundView];
        
    }
    return _cardBackgroundView;
}

-(UILabel *)createrNameLabel{
    if(!_createrNameLabel){
        _createrNameLabel = [[UILabel alloc] init];
        _createrNameLabel.font = [UIFont systemFontOfSize:10 * WIDTH_SCALE];
        _createrNameLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        
    }
    return _createrNameLabel;
}

-(UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:8 * WIDTH_SCALE];
        _timeLabel.textColor = [UIColor colorWithHexString:@"#A7B0B5"];
        
    }
    return _timeLabel;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:10 * WIDTH_SCALE];
        _contentLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        
    }
    return _contentLabel;
}

-(UIImageView *)contentImageView{
    if(!_contentImageView){
        _contentImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TempPicture"]];
        
    }
    return _contentImageView;
}

@end
