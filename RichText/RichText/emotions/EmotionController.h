//
//  EmotionController.h
//  RichText
//
//  Created by Tesiro on 16/10/5.
//  Copyright © 2016年 Tesiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Emoticon.h"

typedef void(^emotionCallBack) (Emoticon * emotion);
@interface EmotionController : UIViewController
@property (nonatomic,copy)emotionCallBack emotionCallBack;
-(instancetype)initWithemotionCallBack:(emotionCallBack)callback;
@end

@interface EmoticonCollectionViewLayout : UICollectionViewFlowLayout

@end