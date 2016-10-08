//
//  FindEmoticon.h
//  RichText
//
//  Created by Tesiro on 16/10/8.
//  Copyright © 2016年 Tesiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "emotionManager.h"

@interface FindEmoticon : NSObject
@property (nonatomic,strong)emotionManager *manager;
+(FindEmoticon*)shareInstance;
-(NSMutableAttributedString*)findATTriString:(NSString*)statusText font:(UIFont*)font;

@end
