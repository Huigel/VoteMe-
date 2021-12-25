//
//  VMPopView.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/13.
//

#import "VMPopView.h"

@implementation VMPopView

-(instancetype)initWithType:(VMPopViewType)type title:(NSString *)titleText content:(NSString *)contentText leftText:(NSString *)leftText rightText:(NSString *)rightText{
    self = [super init];
    
    self.type = type;
    self.titleLabel.text = titleText;
    self.contentLabel.text = contentText;
    [self.leftButton setTitle:leftText forState:(UIControlStateNormal)];
    [self.rightButton setTitle:rightText forState:(UIControlStateNormal)];
    
    [self configureHierachy];
    [self configureAction];
    
    
    return self;
}

-(void)configureHierachy{
    
    [self addSubview:self.maskButton];
    [self.maskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.width.mas_equalTo(320 * WIDTH_SCALE);
        //make.height.mas_equalTo(267 * HEIGHT_SCALE);
    }];
    
    [self.containerView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.containerView);
        make.top.equalTo(self.containerView).with.offset(16 * HEIGHT_SCALE);
        make.width.mas_equalTo(288 * WIDTH_SCALE);
        make.height.mas_equalTo(120 * HEIGHT_SCALE);
    }];
    
    [self.containerView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).with.offset(16 * WIDTH_SCALE);
        make.top.equalTo(self.imageView.mas_bottom).with.offset(16 * HEIGHT_SCALE);
        make.right.equalTo(self.containerView).with.offset(-16 * WIDTH_SCALE);
    }];
    
    [self.containerView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).with.offset(16 * WIDTH_SCALE);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(4 * HEIGHT_SCALE);
        make.right.equalTo(self.containerView).with.offset(-16 * WIDTH_SCALE);
    }];

    [self.containerView addSubview:self.leftButton];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).with.offset(23 * WIDTH_SCALE);
        make.top.equalTo(self.contentLabel.mas_bottom).with.offset(16 * HEIGHT_SCALE);
        make.height.mas_equalTo(32 * HEIGHT_SCALE);
        make.width.mas_equalTo(115 * WIDTH_SCALE);
        make.bottom.equalTo(self.containerView).with.offset(-16 * HEIGHT_SCALE);
    }];
    
    [self.containerView addSubview:self.rightButton];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.containerView).with.offset(-23 * WIDTH_SCALE);
        make.top.equalTo(self.leftButton);
        make.height.mas_equalTo(32 * HEIGHT_SCALE);
        make.width.mas_equalTo(115 * WIDTH_SCALE);
    }];
}

-(void)configureAction{
    
    switch (self.type) {
        case VMPopType0:
            {
                [self.maskButton addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
                    [self removeFromSuperview];
                }]forControlEvents:UIControlEventTouchUpInside];
                
                [self.leftButton addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
                    [self removeFromSuperview];
                }]forControlEvents:UIControlEventTouchUpInside];
            }
            break;
            
        default:
            break;
    }
}

#pragma mark - lazy load

-(UIButton *)maskButton{
    if(!_maskButton){
        _maskButton = [[UIButton alloc] init];
        _maskButton.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.5];
        

    }
    return _maskButton;
}

-(UIView *)containerView{
    if(!_containerView){
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _containerView.layer.cornerRadius = 16 * WIDTH_SCALE;
    }
    return _containerView;
}

-(UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PopWindowImage"]];
    }
    return _imageView;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _titleLabel.font = [UIFont boldSystemFontOfSize:24 * HEIGHT_SCALE];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = [UIColor colorWithHexString:@"#656F77"];
        _contentLabel.font = [UIFont boldSystemFontOfSize:12 * HEIGHT_SCALE];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

-(UIButton *)leftButton{
    if(!_leftButton){
        _leftButton = [[UIButton alloc] init];
        _leftButton.backgroundColor = [UIColor colorWithHexString:@"#F8FCFF"];
        _leftButton.layer.cornerRadius = 12 * WIDTH_SCALE;
        [UIView configureShadow:_leftButton];
        
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:16 * HEIGHT_SCALE];
        [_leftButton setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:(UIControlStateNormal)];
    }
    return _leftButton;
}

-(UIButton *)rightButton{
    if(!_rightButton){
        _rightButton = [[UIButton alloc] init];
        _rightButton.backgroundColor = [UIColor colorWithHexString:@"#DBF2FF"];
        _rightButton.layer.cornerRadius = 12 * WIDTH_SCALE;
        [UIView configureShadow:_rightButton];
        
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:16 * HEIGHT_SCALE];
        [_rightButton setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:(UIControlStateNormal)];
    }
    return _rightButton;
}

@end
