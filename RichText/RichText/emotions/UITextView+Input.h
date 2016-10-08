//
//  UITextView+Input.h
//  RichText
//
//  Created by Tesiro on 16/10/8.
//  Copyright © 2016年 Tesiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Emoticon.h"

@interface UITextView (Input)
-(NSString *)getEmoticonString;
-(void)insertEmoticon:(Emoticon*)emotion;
@end
