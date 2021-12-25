//
//  VMCardOptionView.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/28.
//

#import "VMCardOptionView.h"

@implementation VMCardOptionView

-(instancetype)initWithContent:(NSString *)content havePicture:(BOOL)pictureFlag{
    self = [super init];
    
    self.layer.cornerRadius = 5 * WIDTH_SCALE;
    
    [self addSubview:self.declareLabel];
    [self.declareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(4 * WIDTH_SCALE);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(125 * WIDTH_SCALE);
    }];
    
    self.declareLabel.text = content;
    
    if(pictureFlag){
        [self addSubview:self.havePictureImageView];
        [self.havePictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).with.offset(-5.6 * WIDTH_SCALE);
            make.width.mas_equalTo(8.4 * WIDTH_SCALE);
            make.height.mas_equalTo(7 * HEIGHT_SCALE);
            //make.left.equalTo(self.declareLabel.mas_right).with.offset(5 * WIDTH_SCALE);
        }];
    }
    

    return self;
}

#pragma mark - lazy load
-(UILabel *)declareLabel{
    if(!_declareLabel){
        _declareLabel = [[UILabel alloc] init];
        _declareLabel.font = [UIFont systemFontOfSize:9 * HEIGHT_SCALE];
    }
    return _declareLabel;
}

-(UIImageView *)havePictureImageView{
    if(!_havePictureImageView){
        _havePictureImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"OptionNoPicture"]];
    }
    return _havePictureImageView;
}

@end
