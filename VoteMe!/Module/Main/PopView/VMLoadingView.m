//
//  VMLoadingView.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/24.
//

#import "VMLoadingView.h"

@implementation VMLoadingView

-(instancetype)init{
    self = [super init];
    
    [self configureHierachy];
    
    return self;
}

-(void)configureHierachy{
    
    self.backgroundColor = [UIColor colorWithHexString:@"#081C34" alpha:0.5];
    
    [self addSubview:self.labelBackgroundView];
    [self.labelBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(300 * WIDTH_SCALE);
        make.height.mas_equalTo(200 * HEIGHT_SCALE);
        make.centerX.centerY.equalTo(self);
    }];
    
    [self.labelBackgroundView addSubview:self.loadingGifImageView];
    [self.loadingGifImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.labelBackgroundView);
        make.width.mas_equalTo(60 *WIDTH_SCALE);
        make.height.mas_equalTo(60 * WIDTH_SCALE);
        make.top.equalTo(self.labelBackgroundView).with.offset(50 * HEIGHT_SCALE);
    }];
    
    [self.labelBackgroundView addSubview:self.declarelabel];
    [self.declarelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_labelBackgroundView);
        make.bottom.equalTo(self.labelBackgroundView).with.offset(-20 * HEIGHT_SCALE);
    }];
    
}

#pragma mark - lazy load

-(SDAnimatedImageView *)loadingGifImageView{
    if(!_loadingGifImageView){
        _loadingGifImageView = [SDAnimatedImageView new];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"loadingGifImage" ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        _loadingGifImageView.image = [SDAnimatedImage sd_imageWithData:data];
    }
    return _loadingGifImageView;
}

-(UIView *)labelBackgroundView{
    if(!_labelBackgroundView){
        _labelBackgroundView = [[UIView alloc] init];
        _labelBackgroundView.backgroundColor = [UIColor whiteColor];
        _labelBackgroundView.layer.cornerRadius = 10 * WIDTH_SCALE;
    }
    return _labelBackgroundView;
}

-(UILabel *)declarelabel{
    if(!_declarelabel){
        _declarelabel = [[UILabel alloc] init];
        _declarelabel.text = @"上传图片中";
        //_declarelabel.backgroundColor = [UIColor whiteColor];
        _declarelabel.textColor = [UIColor blackColor];
        _declarelabel.font = [UIFont systemFontOfSize:20 * WIDTH_SCALE];
    }
    return _declarelabel;
}


@end
