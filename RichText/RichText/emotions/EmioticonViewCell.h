//
//  EmioticonViewCell.h
//  RichText
//
//  Created by Tesiro on 16/10/8.
//  Copyright © 2016年 Tesiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Emoticon.h"

@interface EmioticonViewCell : UICollectionViewCell
@property (nonatomic,strong)UIButton *emotionBtn;
@property (nonatomic,strong)Emoticon   *emoticon;

@end
