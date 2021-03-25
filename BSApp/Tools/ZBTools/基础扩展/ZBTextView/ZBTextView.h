//
//  ZBTextView.h
//  Marketing
//
//  Created by lizb on 16/8/25.
//  Copyright © 2016年 forr. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 UITextView with placeholder support
 */
@interface ZBTextView : UITextView

/**
 Set textView's placeholder text. Default is nil.
 */
@property(nonatomic, copy)   NSString *placeholder;

//@property(nonatomic,strong) UIColor *laceholderColor; //文字颜色
@end
