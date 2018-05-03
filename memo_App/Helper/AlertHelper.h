//
//  AlertHelper.h
//  memo_App
//
//  Created by kawaharadai on 2017/12/16.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol AlertHelperDelegate <NSObject>
- (void)allDelete;
@end

@interface AlertHelper : NSObject
@property (nonatomic, weak) id<AlertHelperDelegate> delegate;
- (UIAlertController *)createAllDeleteActionSheet:(NSString *)deleteButtonTitle
                                cancelButtonTitle:(NSString *)cancelButtonTitle;
@end
