//
//  VMVoteDetailHostCell.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/30.
//

#import "VMVoteDetailHostCell.h"

@implementation VMVoteDetailHostCell

-(instancetype)initWithCouldVoteFlag:(BOOL)flag{
    self = [super init];
    
    self.couldVote = flag;
    self.backgroundColor = [UIColor colorWithHexString:kVMBackgroundColor];
    [self configureHierachy];
    
    return self;
}

-(instancetype)init{
    self = [super init];
    
    self.backgroundColor = [UIColor colorWithHexString:kVMBackgroundColor];
    [self configureHierachy];
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)configureHierachy{
    
    
    
    [self.contentView addSubview:self.createrNameLabel];
    [self.createrNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(10 * HEIGHT_SCALE);
        make.left.equalTo(self.contentView).with.offset(21 * WIDTH_SCALE);
        make.height.mas_equalTo(22 * HEIGHT_SCALE);
    }];
    
    [self.contentView addSubview:self.deadlineLabel];
    [self.deadlineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(5 * HEIGHT_SCALE);
        make.right.equalTo(self.contentView).with.offset(-12 * WIDTH_SCALE);
        make.height.mas_equalTo(18 * HEIGHT_SCALE);
    }];
    
    [self.contentView addSubview:self.endTimeLabel];
    [self.endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.deadlineLabel.mas_bottom);
        make.right.equalTo(self.deadlineLabel);
        make.height.mas_equalTo(15 * HEIGHT_SCALE);
    }];
    
    [self.contentView addSubview:self.titleBackgroundView];
    [self.titleBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.createrNameLabel.mas_bottom).with.offset(13 * HEIGHT_SCALE);
        make.centerX.equalTo(self.contentView);
        make.width.mas_equalTo(350 * WIDTH_SCALE);
    }];
    
    [self.titleBackgroundView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleBackgroundView).with.offset(25 * HEIGHT_SCALE);
        make.left.equalTo(self.titleBackgroundView).with.offset(10 * WIDTH_SCALE);
        make.right.equalTo(self.titleBackgroundView).with.offset(-10 * WIDTH_SCALE);
        make.bottom.equalTo(self.titleBackgroundView).with.offset(-20 * HEIGHT_SCALE);
    }];
    
    [self.contentView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleBackgroundView.mas_bottom).with.offset(22 * HEIGHT_SCALE);
        make.centerX.equalTo(self.contentView);
        make.width.mas_equalTo(336 * WIDTH_SCALE);
    }];
    
//    [self.optionArray addObject:[[VMVoteDetailOptionView alloc] init]];
//    [self.contentView addSubview:self.optionArray[0]];
//    [self.optionArray[0] mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.detailLabel.mas_bottom).with.offset(22 * HEIGHT_SCALE);
//        make.centerX.equalTo(self.contentView);
////        make.width.mas_equalTo(157 * WIDTH_SCALE);
////        make.height.mas_equalTo(40 * HEIGHT_SCALE);
//    }];
    if(self.couldVote){
        [self.contentView addSubview:self.submitButton];
        [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.detailLabel.mas_bottom).with.offset(22 * HEIGHT_SCALE);
            make.centerX.equalTo(self.contentView);
            make.width.mas_equalTo(157 * WIDTH_SCALE);
            make.height.mas_equalTo(40 * HEIGHT_SCALE);
        }];
    }

    
//    UILabel *messageLabel = [[UILabel alloc] init];
//    messageLabel.text = @"留言区";
//    messageLabel.textColor = [UIColor colorWithHexString:@"#081C34"];
//    messageLabel.font = [UIFont boldSystemFontOfSize:12 * WIDTH_SCALE];
    
    [self.contentView addSubview:self.messageLabel];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if(self.couldVote){
            make.top.equalTo(self.submitButton.mas_bottom).with.offset(25 * HEIGHT_SCALE);
        }else{
            make.top.equalTo(self.detailLabel.mas_bottom).with.offset(25 * HEIGHT_SCALE);
        }
        make.left.equalTo(self.contentView).with.offset(23 * WIDTH_SCALE);
    }];
    
    UIView *barView = [[UIView alloc] init];
    barView.backgroundColor = [UIColor colorWithHexString:@"#A6B9FF"];
    [self.contentView addSubview:barView];
    [barView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageLabel.mas_bottom).with.offset(4 * HEIGHT_SCALE);
        make.centerX.equalTo(self.messageLabel);
        make.width.mas_equalTo(30 * WIDTH_SCALE);
        make.height.mas_equalTo(2 * HEIGHT_SCALE);
        make.bottom.equalTo(self.contentView).with.offset(-2 * HEIGHT_SCALE);
    }];
    
//    [self mas_makeConstraints:^(MASConstraintMaker *make) {
//        //make.bottom.equalTo(barView).with.offset(2 * HEIGHT_SCALE);
//        make.width.mas_equalTo(UIScreen.mainScreen.bounds.size.width);
//    }];
    
}


#pragma mark - lazy load
-(UILabel *)createrNameLabel{
    if(!_createrNameLabel){
        _createrNameLabel = [[UILabel alloc] init];
        _createrNameLabel.font = [UIFont systemFontOfSize:14 * WIDTH_SCALE];
        _createrNameLabel.text = @"李云龙";
        _createrNameLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    }
    return _createrNameLabel;
}

-(UILabel *)deadlineLabel{
    if(!_deadlineLabel){
        _deadlineLabel = [[UILabel alloc] init];
        _deadlineLabel.font = [UIFont systemFontOfSize:12 * WIDTH_SCALE];
        _deadlineLabel.text = @"1天2h";
        _deadlineLabel.textColor = [UIColor colorWithHexString:@"#FFC76F"];
    }
    return _deadlineLabel;
}

-(UILabel *)endTimeLabel{
    if(!_endTimeLabel){
        _endTimeLabel = [[UILabel alloc] init];
        _endTimeLabel.font = [UIFont systemFontOfSize:10 * WIDTH_SCALE];
        _endTimeLabel.textColor = [UIColor colorWithHexString:@"#A7B0B5"];
        _endTimeLabel.text = @"猴年马月";
    }
    return _endTimeLabel;
}

-(UIView *)titleBackgroundView{
    if(!_titleBackgroundView){
        _titleBackgroundView = [[UIView alloc] init];
        _titleBackgroundView.backgroundColor = [UIColor whiteColor];
        _titleBackgroundView.layer.cornerRadius = 12 * WIDTH_SCALE;
        
        _titleBackgroundView.layer.shadowColor = [UIColor grayColor].CGColor;
        _titleBackgroundView.layer.shadowOffset = CGSizeMake(0 * WIDTH_SCALE, 2 * HEIGHT_SCALE);
        _titleBackgroundView.layer.shadowOpacity = 0.4;
        _titleBackgroundView.layer.shadowRadius = 3 * WIDTH_SCALE;
    }
    return _titleBackgroundView;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:18 * WIDTH_SCALE];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _titleLabel.numberOfLines = 0;
        //_titleLabel.text = @"这里是标题";
    }
    return _titleLabel;
}

-(UILabel *)detailLabel{
    if(!_detailLabel){
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize:12 * WIDTH_SCALE];
        _detailLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _detailLabel.numberOfLines = 0;
        //_detailLabel.text = @"这里是详情";
    }
    return _detailLabel;
}

-(UIImageView *)detailImageView{
    if(!_detailImageView){
        _detailImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TempPicture"]];
        

        
    }
    return _detailImageView;
}

-(UILabel *)voterNumberLabel{
    if(!_voterNumberLabel){
        _voterNumberLabel = [[UILabel alloc] init];
        _voterNumberLabel.font = [UIFont systemFontOfSize:12 * WIDTH_SCALE];
        _voterNumberLabel.textColor = [UIColor colorWithHexString:@"#C4C4C4"];
    }
    return _voterNumberLabel;
}

-(NSMutableArray<VMVoteDetailOptionView *> *)optionArray{
    if(!_optionArray){
        _optionArray = [[NSMutableArray<VMVoteDetailOptionView *> alloc] init];
    }
    return _optionArray;
}

-(UIButton *)submitButton{
    if(!_submitButton){
        _submitButton = [[UIButton alloc] init];
        _submitButton.backgroundColor = [UIColor colorWithHexString:@"#F8FCFF"];
        _submitButton.layer.cornerRadius = 20 * WIDTH_SCALE;
        
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:16 * WIDTH_SCALE];
        [_submitButton setTitle:@"提交" forState:(UIControlStateNormal)];
        [_submitButton setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:(UIControlStateNormal)];
        
        [UIView configureShadow:_submitButton];
        
    }
    return _submitButton;
}

-(UILabel *)messageLabel{
    if(!_messageLabel){
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.text = @"留言区";
        _messageLabel.textColor = [UIColor colorWithHexString:@"#081C34"];
        _messageLabel.font = [UIFont boldSystemFontOfSize:12 * WIDTH_SCALE];
    }
    return _messageLabel;
}


@end
