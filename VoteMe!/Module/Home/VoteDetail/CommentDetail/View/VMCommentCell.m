//
//  VMCommentCell.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/6.
//

#import "VMCommentCell.h"

@implementation VMCommentCell

-(instancetype)init{
    self = [super init];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor colorWithHexString:kVMBackgroundColor];
    
    [self configureHierachy];
    
    return self;
}

-(void)configureHierachy{
    
    [self.contentView addSubview:self.separaterLine];
    [self.separaterLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(36 * WIDTH_SCALE);
        make.right.equalTo(self.contentView).with.offset(-36 * WIDTH_SCALE);
        make.height.mas_equalTo(0.5 * HEIGHT_SCALE);
        make.top.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(36 * WIDTH_SCALE);
        make.right.equalTo(self.contentView).with.offset(-36 * WIDTH_SCALE);
        //make.height.mas_equalTo(0.5 * HEIGHT_SCALE);
        make.top.equalTo(self.contentView).with.offset(12 * HEIGHT_SCALE);
    }];
    
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).with.offset(2 * HEIGHT_SCALE);
        make.right.equalTo(self.contentView).with.offset(-46 * WIDTH_SCALE);
        //make.height.mas_equalTo(0.5 * HEIGHT_SCALE);
        make.bottom.equalTo(self.contentView).with.offset(-8 * HEIGHT_SCALE);
    }];

}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - lazy load

-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:10 * WIDTH_SCALE];
        _contentLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _contentLabel.numberOfLines = 0;
        _contentLabel.text = @"回复人ID：这里是留言内容，这里是留言内容，这里是留言内容，这里是留言内容，这里是留言内容，这里是留言内容，这里是留言内容，这里是留言内容，这里是留言内容。";
        
    }
    return _contentLabel;
}

-(UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:8 * WIDTH_SCALE];
        _timeLabel.textColor = [UIColor colorWithHexString:@"#A7B0B5"];
        _timeLabel.text = @"千秋万代";
        
    }
    return _timeLabel;
}

-(UIView *)separaterLine{
    if(!_separaterLine){
        _separaterLine = [[UIView alloc] init];
        _separaterLine.backgroundColor = [UIColor colorWithHexString:@"#CDD0CB"];
    }
    return _separaterLine;
}


@end
