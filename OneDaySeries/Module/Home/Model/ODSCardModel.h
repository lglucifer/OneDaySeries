//
//  ODSCardModel.h
//  OneDaySeries
//
//  Created by LiuXiaoyu on 16/7/1.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSBaseModel.h"

typedef NS_ENUM(NSUInteger, ODSImageCardLayoutType) {
    ODSImageCardLayout_Horizontal   = (0),  //横图
    ODSImageCardLayout_Vertical     = (1)   //竖图
};

typedef NS_ENUM(NSUInteger, ODSCardMediaType) {
    ODSCardMediaType_Audio = (0),
    ODSCardMediaType_Image = (1),
    ODSCardMediaType_Text  = (2)
};

@interface ODSCardModel : ODSBaseModel

@property (nonatomic, assign) ODSCardMediaType mediaType;

@end

@interface ODSAudioCardModel : ODSCardModel

@end

@interface ODSImageCardModel : ODSCardModel

@property (nonatomic, copy) NSString *thumbImageURLString;

@property (nonatomic, copy) NSString *bigImageURLString;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat radio;

@property (nonatomic, assign) ODSImageCardLayoutType layoutType;

@end

@interface ODSTextCardModel : ODSCardModel

@property (nonatomic, copy) NSString *htmlString;

@end