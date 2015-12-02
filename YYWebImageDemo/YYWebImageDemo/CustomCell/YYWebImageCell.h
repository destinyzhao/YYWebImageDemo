//
//  YYWebImageCell.h
//  YYWebImageDemo
//
//  Created by Alex on 15/12/2.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYWebImageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet YYAnimatedImageView *webImageView;
@property (nonatomic, strong) CAShapeLayer *progressLayer;

- (void)setImageURL:(NSURL *)url;

@end
