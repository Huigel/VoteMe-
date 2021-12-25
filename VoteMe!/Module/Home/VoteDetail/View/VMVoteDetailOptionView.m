//
//  VMVoteDetailOptionView.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/30.
//

#import "VMVoteDetailOptionView.h"

@implementation VMVoteDetailOptionView

//-(instancetype)init{
//    self = [super init];
//    
//    self.layer.cornerRadius = 10 * WIDTH_SCALE;
//    self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
//    
//    [UIView configureShadow:self];
//    
//    [self configureHierachy];
//    return self;
//}

-(instancetype)initWithType:(VMOptionType)type{
    self = [super init];
    
//    self.layer.cornerRadius = 10 * WIDTH_SCALE;
//    self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    
    self.optionType = type;
    
    //[UIView configureShadow:self];
    
    [self configureHierachy];
    return self;
}


-(void)configureHierachy{
    
//    [self mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(326 * WIDTH_SCALE);
//    }];
    if(self.optionType == VMOptionYypeUnselected){
        
        [self addSubview:self.backgroundView];
        [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [self.backgroundView addSubview:self.actionButton];
        [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.backgroundView);
        }];
        
        [self.actionButton addSubview:self.declareLabel];
        [self.declareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.actionButton).with.offset(15 * HEIGHT_SCALE);
            make.left.equalTo(self.actionButton).with.offset(12 * WIDTH_SCALE);
            make.bottom.equalTo(self.actionButton).with.offset(-15 * HEIGHT_SCALE);
        }];
        
        [self.actionButton addSubview:self.optionPictureImageView];
        [self.optionPictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.actionButton).with.offset(8 * HEIGHT_SCALE);
            make.right.equalTo(self.actionButton).with.offset(-10 * WIDTH_SCALE);
            make.left.equalTo(self.declareLabel.mas_right).with.offset(10 * WIDTH_SCALE);
            make.width.mas_equalTo(45 * WIDTH_SCALE);
            make.height.mas_equalTo(30 * HEIGHT_SCALE);
        }];
        
        return;
    }
    
    if(self.optionType == VMOptionYypeSelected){
        
        [self addSubview:self.backgroundView];
        [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
            make.right.equalTo(self).with.offset(-30 * WIDTH_SCALE);
        }];
        
        [self.backgroundView addSubview:self.actionButton];
        [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.backgroundView);
        }];
        
        [self.actionButton addSubview:self.rateView];
        [self.rateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self.actionButton);
            make.width.mas_equalTo(0);
        }];
        
        [self.actionButton addSubview:self.declareLabel];
        [self.declareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.actionButton).with.offset(15 * HEIGHT_SCALE);
            make.left.equalTo(self.actionButton).with.offset(12 * WIDTH_SCALE);
            make.bottom.equalTo(self.actionButton).with.offset(-15 * HEIGHT_SCALE);
        }];
        
        [self.actionButton addSubview:self.optionPictureImageView];
        [self.optionPictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.actionButton).with.offset(8 * HEIGHT_SCALE);
            make.right.equalTo(self.actionButton).with.offset(-10 * WIDTH_SCALE);
            make.left.equalTo(self.declareLabel.mas_right).with.offset(10 * WIDTH_SCALE);
            make.width.mas_equalTo(45 * WIDTH_SCALE);
            make.height.mas_equalTo(30 * HEIGHT_SCALE);
        }];
        
        [self addSubview:self.numLabel];
        [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backgroundView.mas_right).with.offset(10 * WIDTH_SCALE);
            make.top.equalTo(self).with.offset(12 * HEIGHT_SCALE);
        }];
        
        return;
    }
}


#pragma mark - lazy load
-(UIView *)backgroundView{
    if(!_backgroundView){
        _backgroundView = [[UIView alloc] init];
        _backgroundView.layer.cornerRadius = 10 * WIDTH_SCALE;
        _backgroundView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        [UIView configureShadow:_backgroundView];
    }
    return _backgroundView;
}

-(UILabel *)numLabel{
    if(!_numLabel){
        _numLabel = [[UILabel alloc] init];
        _numLabel.textColor = [UIColor colorWithHexString:@"#CDD0CB"];
        _numLabel.font = [UIFont systemFontOfSize:12 * HEIGHT_SCALE];
    }
    return _numLabel;
}

-(UIButton *)actionButton{
    if(!_actionButton){
        _actionButton = [[UIButton alloc] init];
    }
    return _actionButton;
}

-(UILabel *)declareLabel{
    if(!_declareLabel){
        _declareLabel = [[UILabel alloc] init];
        _declareLabel.font = [UIFont systemFontOfSize:12 * WIDTH_SCALE];
        //_declareLabel.text = @"吃咖喱饭！！！！";
        _declareLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _declareLabel.numberOfLines = 0;
    }
    return _declareLabel;
}

-(UIImageView *)optionPictureImageView{
    if(!_optionPictureImageView){
        _optionPictureImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TempPicture"]];
    }
    return _optionPictureImageView;
}
-(UIView *)rateView{
    if(!_rateView){
        _rateView = [[UIView alloc] init];
        _rateView.backgroundColor = [UIColor colorWithHexString:@"#A6B9FF"];
        _rateView.layer.cornerRadius = 10 * WIDTH_SCALE;
    }
    return _rateView;
}
@end
