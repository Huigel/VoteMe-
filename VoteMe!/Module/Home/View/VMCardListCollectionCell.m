//
//  CICardListCollectionCell.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/24.
//

#import "VMCardListCollectionCell.h"
#import "VMMainViewController.h"
#import "VMVoteDetailViewController.h"

@implementation VMCardListCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.layer.cornerRadius = 12 * WIDTH_SCALE;
    
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0 * WIDTH_SCALE, 2 * HEIGHT_SCALE);
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowRadius = 3 * WIDTH_SCALE;
    
    self.optionArray = [[NSMutableArray alloc] init];
    
//    NSLog(@"创建cell");
//    [self.contentView addSubview:self.countLabel];
    
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
//    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.contentView);
//    }];
    
    [self addSubview:self.masButton];
    [self.masButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.masButton addSubview:self.createrLabel];
    [self.createrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.masButton).with.offset(18 * HEIGHT_SCALE);
        make.left.equalTo(self.masButton).with.offset(11 * WIDTH_SCALE);
        make.height.mas_equalTo(10 * HEIGHT_SCALE);
    }];
    
    [self.masButton addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.masButton).with.offset(18 * HEIGHT_SCALE);
        make.right.equalTo(self.masButton).with.offset(-12 * WIDTH_SCALE);
        //make.height.mas_equalTo(10 * HEIGHT_SCALE);
    }];
    
    [self.masButton addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.masButton).with.offset(41 * HEIGHT_SCALE);
        make.left.equalTo(self.masButton).with.offset(13 * WIDTH_SCALE);
        make.right.equalTo(self.masButton).with.offset(-12 * WIDTH_SCALE);
        //make.height.mas_equalTo(34 * HEIGHT_SCALE);
        make.width.mas_equalTo(145 * WIDTH_SCALE);
    }];
    
    [self.masButton addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(6 * HEIGHT_SCALE);
        //make.left.equalTo(self.titleLabel).with.offset(13 * WIDTH_SCALE);
       // make.right.equalTo(self.titleLabel).with.offset(12 * WIDTH_SCALE);
        make.left.right.equalTo(self.titleLabel);
        //make.bottom.equalTo(self.masButton);
        //make.height.mas_equalTo(34 * HEIGHT_SCALE);
    }];
    

    
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
//
//    [self setNeedsLayout];
//    [self layoutIfNeeded];
//
//    NSLog(@"func 3 before %f",layoutAttributes.frame.size.height);
//
//    CGSize newSize = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//
//    CGRect newFrame = layoutAttributes.frame;
//    newFrame.size.height = newSize.height;
//
//    layoutAttributes.frame = newFrame;
//
//    NSLog(@"func 3 after %f",layoutAttributes.frame.size.height);
    
    return layoutAttributes;
}

-(void)configureCell:(int)cardID{
    //test
//    [self.countLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView).with.offset(12 * WIDTH_SCALE);
//        make.right.equalTo(self.contentView).with.offset(-12 * WIDTH_SCALE);
//        make.top.equalTo(self.contentView).with.offset(10 * HEIGHT_SCALE).priority(999);
//        make.bottom.equalTo(self.contentView).with.offset(-10 * HEIGHT_SCALE).priority(999);
//        make.height.mas_equalTo((cardID % 9 + 1 ) * 14 * HEIGHT_SCALE);
//    }];
    

}

#pragma mark - lazy load
-(UIButton *)masButton{
    if(!_masButton){
        _masButton = [[UIButton alloc] init];
        [_masButton addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
            
            VMVoteDetailViewController *vc = [[VMVoteDetailViewController alloc] initWithHostModel:self.cellModel];
            [[VMMainViewController sharedInstance].navigationController pushViewController:vc animated:true];
            
        }]forControlEvents:UIControlEventTouchUpInside];
    }
    return _masButton;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 2;
        _titleLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _titleLabel.font = [UIFont systemFontOfSize:12 * WIDTH_SCALE];
        _titleLabel.text = @"我是题目";
    }
    return _titleLabel;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 3;
        _contentLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _contentLabel.font = [UIFont systemFontOfSize:7 * WIDTH_SCALE];
        _contentLabel.text = @"我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容";
    }
    return _contentLabel;
}

-(UILabel *)createrLabel{
    if(!_createrLabel){
        _createrLabel = [[UILabel alloc] init];
        _createrLabel.numberOfLines = 1;
        _createrLabel.textColor = [UIColor colorWithHexString:@"#656F77"];
        _createrLabel.font = [UIFont systemFontOfSize:8 * WIDTH_SCALE];
        _createrLabel.text = @"张三";
    }
    return _createrLabel;
}

-(UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.numberOfLines = 1;
        _timeLabel.textColor = [UIColor colorWithHexString:@"#FFC76F"];
        _timeLabel.font = [UIFont systemFontOfSize:7 * WIDTH_SCALE];
        _timeLabel.text = @"猴年马月";
    }
    return _timeLabel;
}



-(UILabel *)countLabel{
    if(!_countLabel){
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10 * WIDTH_SCALE, 10 * HEIGHT_SCALE)];
        _countLabel.numberOfLines = 5;
        _countLabel.text = @"test";
        _countLabel.textColor = [UIColor blackColor];
        _countLabel.backgroundColor = [UIColor whiteColor];
        
    }
    return _countLabel;
}


@end
