//
//  YYWebImageCell.m
//  YYWebImageDemo
//
//  Created by Alex on 15/12/2.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import "YYWebImageCell.h"

@implementation YYWebImageCell


- (void)awakeFromNib {
    // Initialization code
    
    CGFloat lineHeight = 4;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(_webImageView.width, 0)];
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = CGRectMake(0, 0, _webImageView.width, lineHeight);
    _progressLayer.lineWidth = lineHeight;
    _progressLayer.path = path.CGPath;
    _progressLayer.strokeColor = [UIColor colorWithRed:0.000 green:0.640 blue:1.000 alpha:0.720].CGColor;
    _progressLayer.lineCap = kCALineCapButt;
    _progressLayer.strokeStart = 0;
    _progressLayer.strokeEnd = 0;
    [_webImageView.layer addSublayer:_progressLayer];
}

- (void)setImageURL:(NSURL *)url {
  
    __weak typeof(self) weakSelf = self;
    
    [CATransaction begin];
    [CATransaction setDisableActions: YES];
    self.progressLayer.hidden = YES;
    self.progressLayer.strokeEnd = 0;
    [CATransaction commit];
    
    [_webImageView yy_setImageWithURL:url
                       placeholder:nil
                           options:YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity | YYWebImageOptionSetImageWithFadeAnimation
                          progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                              if (expectedSize > 0 && receivedSize > 0) {
                                  CGFloat progress = (CGFloat)receivedSize / expectedSize;
                                  progress = progress < 0 ? 0 : progress > 1 ? 1 : progress;
                                  if (weakSelf.progressLayer.hidden)
                                      weakSelf.progressLayer.hidden = NO;
                                  weakSelf.progressLayer.strokeEnd = progress;
                              }
                          } transform:nil
                        completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
                            if (stage == YYWebImageStageFinished) {
                                weakSelf.progressLayer.hidden = YES;
                            }
                        }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
