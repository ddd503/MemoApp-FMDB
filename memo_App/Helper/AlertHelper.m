//
//  AlertHelper.m
//  memo_App
//
//  Created by kawaharadai on 2017/12/16.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import "AlertHelper.h"

@implementation AlertHelper
- (UIAlertController *)createAllDeleteActionSheet:(NSString *)deleteButtonTitle
                       cancelButtonTitle:(NSString *)cancelButtonTitle {
    
    __weak typeof(self) wself = self;

    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil
                                                                              message:nil
                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *action) {
                                                       NSLog(@"キャンセルしました。");
                                                   }];
    
    UIAlertAction *allDelete = [UIAlertAction actionWithTitle:deleteButtonTitle
                                                   style:UIAlertActionStyleDestructive
                                                 handler:^(UIAlertAction *action) {
                                                     if ([wself.delegate respondsToSelector:@selector(allDelete)]) {
                                                         [wself.delegate allDelete];
                                                     }
                                                 }];
    
    [actionSheet addAction:cancel];
    [actionSheet addAction:allDelete];
    
    return actionSheet;
}
@end
