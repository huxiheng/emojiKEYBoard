//
//  EmotionPackage.h
//  RichText
//
//  Created by Tesiro on 16/10/8.
//  Copyright © 2016年 Tesiro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmotionPackage : NSObject
@property (nonatomic,strong)NSMutableArray *emoticons;
- (instancetype)initWithID:(NSString *)ids;
@end
