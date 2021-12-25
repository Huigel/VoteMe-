//
//  VMUserPageButton.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/28.
//

#import "VMUserPageButton.h"

@implementation VMUserPageButton

-(instancetype)initWithImageName:(NSString *)imageName labelTaxt:(NSString *)labelText{
    self = [super init];
    
    [self addSubview:self.iconBaseView];
    [self.iconBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(27 * HEIGHT_SCALE);
        make.left.equalTo(self);
        make.width.mas_equalTo(55 * WIDTH_SCALE);
        make.height.mas_equalTo(55 * WIDTH_SCALE);
    }];
    
    [self.iconBaseView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.iconBaseView);
        make.width.mas_equalTo(25 * WIDTH_SCALE);
        make.height.mas_equalTo(25 * WIDTH_SCALE);
    }];
    
    [self addSubview:self.iconDeclareLabel];
    [self.iconDeclareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(83 * WIDTH_SCALE);
        make.height.mas_equalTo(18 * WIDTH_SCALE);
    }];
    
    [self addSubview:self.actionButton];
    [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    self.iconImageView.image = [UIImage imageNamed:imageName];
    self.iconDeclareLabel.text = labelText;
    
    
    
    return self;
}


#pragma mark - lazy load
-(UIView *)iconBaseView{
    if(!_iconBaseView){
        _iconBaseView = [[UIView alloc] init];
        _iconBaseView.layer.cornerRadius = 55 / 2 * WIDTH_SCALE;
        
        _iconBaseView.layer.shadowColor = [UIColor grayColor].CGColor;
        _iconBaseView.layer.shadowOffset = CGSizeMake(0 * WIDTH_SCALE, 2 * HEIGHT_SCALE);
        _iconBaseView.layer.shadowOpacity = 0.4;
        _iconBaseView.layer.shadowRadius = 3 * WIDTH_SCALE;
        _iconBaseView.backgroundColor = [UIColor whiteColor];
    }
    return _iconBaseView;
}

-(UIImageView *)iconImageView{
    if(!_iconImageView){
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

-(UILabel *)iconDeclareLabel{
    if(!_iconDeclareLabel){
        _iconDeclareLabel = [[UILabel alloc] init];
        _iconDeclareLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _iconDeclareLabel.font = [UIFont systemFontOfSize:14 * WIDTH_SCALE];
    }
    return _iconDeclareLabel;
}

-(UIButton *)actionButton{
    if(!_actionButton){
        _actionButton = [[UIButton alloc] init];
    }
    return _actionButton;
}

@end
