//
//  FXQScan.m
//  Erweimasaomiao
//
//  Created by 付晓强 on 16/10/27.
//  Copyright © 2016年 付晓强. All rights reserved.
//

#import "FXQScan.h"

#define REMINDTEXT @"将二维码放入框内，即可自动扫描"

#define SCANSPACEOFFSET 0.15f
#define SCREENBOUNDS [UIScreen mainScreen].bounds
#define SCREENWIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define SCREENHEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)

@interface FXQScan ()

<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession * session;
@property (nonatomic, strong) AVCaptureDeviceInput * input;
@property (nonatomic, strong) AVCaptureMetadataOutput * output;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer * scanView;

@property (nonatomic, strong) CAShapeLayer * maskLayer;
@property (nonatomic, strong) CAShapeLayer * shadowLayer;
@property (nonatomic, strong) CAShapeLayer * scanRectLayer;

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, assign) CGRect scanRect;
@property (nonatomic, strong) UILabel * remind;

@end

@implementation FXQScan

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.2];
        [self.layer addSublayer: self.scanView];
        [self setupScanRect];
        [self addSubview:self.remind];
        [self addSubview:self.backBtn];
        self.layer.masksToBounds = YES;
        [self scanLine];
        
    }
    return self;
}

- (void)scanLine{
    
    UIView *view = [[UIView alloc] initWithFrame:self.scanRect];
    view.backgroundColor = [UIColor clearColor];
    
    CAShapeLayer *animation = [CAShapeLayer layer];
    animation.frame = CGRectMake(0, 0, self.scanRect.size.width, 2);
    animation.strokeColor = RGBA(102, 176, 250, 1).CGColor;
    animation.lineWidth = 2;
    animation.shadowColor = RGBA(102, 176, 250, 1).CGColor;
    animation.shadowOffset = CGSizeMake(0, -1);
    animation.shadowOpacity = 1;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(self.scanRect.size.width, 0)];
    animation.path = path.CGPath;
    [view.layer addSublayer:animation];
    CAKeyframeAnimation *key = [CAKeyframeAnimation animation];
    key.keyPath = @"position.y";
    key.values = @[@(0),@(self.scanRect.size.height)];
    key.duration = 5;
    key.repeatCount = MAXFLOAT;
    [animation addAnimation:key forKey:@"move"];
    [self addSubview:view];
}

- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 30, 30)];
        [_backBtn setTitle:@"<" forState:UIControlStateNormal];
        [_backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _backBtn.backgroundColor = [UIColor clearColor];
        [_backBtn addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];

    }
    return _backBtn;
}

/**
 *  提示文本
 */
- (UILabel *)remind
{
    if (!_remind) {
        CGRect textRect = self.scanRect;
        textRect.origin.y += CGRectGetHeight(textRect) + 20;
        textRect.size.height = 25.f;
        
        _remind = [[UILabel alloc] initWithFrame: textRect];
        _remind.font = [UIFont systemFontOfSize: 15.f * SCREENWIDTH / 375.f];
        _remind.textColor = [UIColor whiteColor];
        _remind.textAlignment = NSTextAlignmentCenter;
        _remind.text = REMINDTEXT;
        _remind.backgroundColor = [UIColor clearColor];
    }
    return _remind;
}



/**
 *  会话对象
 */
- (AVCaptureSession *)session
{
    if (!_session) {
        _session = [AVCaptureSession new];
        [_session setSessionPreset: AVCaptureSessionPresetHigh];    //高质量采集
        [self setupIODevice];
    }
    
    return _session;
}


/**
 *  配置输入输出设置
 */
- (void)setupIODevice
{
    if ([self.session canAddInput: self.input]) {
        [_session addInput: _input];
    }
    if ([self.session canAddOutput: self.output]) {
        [_session addOutput: _output];
        _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    }
}

/**
 *  扫描视图
 */
- (AVCaptureVideoPreviewLayer *)scanView
{
    if (!_scanView) {
        _scanView = [AVCaptureVideoPreviewLayer layerWithSession: self.session];
        _scanView.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _scanView.frame = self.bounds;
    }
    return _scanView;
}

/**
 *  视频输入设备
 */
- (AVCaptureDeviceInput *)input
{
    if (!_input) {
        AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType: AVMediaTypeVideo];
        _input = [AVCaptureDeviceInput deviceInputWithDevice: device error: nil];
    }
    return _input;
}

/**
 *  数据输出对象
 */
- (AVCaptureMetadataOutput *)output
{
    if (!_output) {
        _output = [AVCaptureMetadataOutput new];
        [_output setMetadataObjectsDelegate: self queue: dispatch_get_main_queue()];
    }
    return _output;
}

/**
 *  扫描框
 */
- (CAShapeLayer *)scanRectLayer
{
    if (!_scanRectLayer) {
        CGRect scanRect = self.scanRect;
        scanRect.origin.x -= 1;
        scanRect.origin.y -= 1;
        scanRect.size.width += 2;
        scanRect.size.height += 2;
        //NSLog(@"scanRect==%@",NSStringFromCGRect(scanRect));
        _scanRectLayer = [CAShapeLayer layer];
        _scanRectLayer.path = [UIBezierPath bezierPathWithRect: scanRect].CGPath;
        _scanRectLayer.fillColor = [UIColor clearColor].CGColor;
        _scanRectLayer.strokeColor = [UIColor orangeColor].CGColor;

    }
    return _scanRectLayer;
}

/**
 *  扫描范围
 */
- (CGRect)scanRect
{
    if (CGRectEqualToRect(_scanRect, CGRectZero)) {
        CGRect rectOfInterest = self.output.rectOfInterest;
//        NSLog(@"self.output.rectOfInterest==%@",NSStringFromCGRect(rectOfInterest));
        CGFloat yOffset = rectOfInterest.size.width - rectOfInterest.origin.x;
        CGFloat xOffset = 1 - 2 * SCANSPACEOFFSET;
        _scanRect = CGRectMake(rectOfInterest.origin.y * SCREENWIDTH, rectOfInterest.origin.x * SCREENHEIGHT, xOffset * SCREENWIDTH, yOffset * SCREENHEIGHT);
    }
    return _scanRect;
}


/**
 *  配置扫描范围
 */
- (void)setupScanRect
{
    CGFloat size = SCREENWIDTH * (1 - 2 * SCANSPACEOFFSET);
    CGFloat minY = (SCREENHEIGHT - size) * 0.5 / SCREENHEIGHT;
    CGFloat maxY = (SCREENHEIGHT + size) * 0.5 / SCREENHEIGHT;
    self.output.rectOfInterest = CGRectMake(minY, SCANSPACEOFFSET, maxY, 1 - SCANSPACEOFFSET * 2);
    
    [self.layer addSublayer: self.shadowLayer];
    [self.layer addSublayer: self.scanRectLayer];
    [self addCornerLayer];
    
}

/*
 * 添加4个边角
 */

- (void)addCornerLayer{
    CAShapeLayer *aLayer = [CAShapeLayer layer];
    [self addCorner:aLayer withStartPoint:CGPointMake(20, 0) andBetween:CGPointMake(0, 0) andEndPoint:CGPointMake(0, 20)];
    CAShapeLayer *bLayer = [CAShapeLayer layer];
    [self addCorner:bLayer withStartPoint:CGPointMake(20, self.scanRect.size.height) andBetween:CGPointMake(0, self.scanRect.size.height) andEndPoint:CGPointMake(0, self.scanRect.size.width-20)];
    CAShapeLayer *cLayer = [CAShapeLayer layer];
    [self addCorner:cLayer withStartPoint:CGPointMake(self.scanRect.size.width-20, self.scanRect.size.height) andBetween:CGPointMake(self.scanRect.size.width, self.scanRect.size.height) andEndPoint:CGPointMake(self.scanRect.size.width, self.scanRect.size.width-20)];
    
    CAShapeLayer *dLayer = [CAShapeLayer layer];
    [self addCorner:dLayer withStartPoint:CGPointMake(self.scanRect.size.width-20, 0) andBetween:CGPointMake(self.scanRect.size.width, 0) andEndPoint:CGPointMake(self.scanRect.size.width, 20)];
}

- (void)addCorner:(CAShapeLayer *)alayer withStartPoint:(CGPoint)startPoint andBetween:(CGPoint)bPoint andEndPoint:(CGPoint)endPoint{
    alayer.frame = self.scanRect;
    alayer.strokeColor = RGBA(102, 176, 250, 1).CGColor;
    alayer.fillColor = [UIColor clearColor].CGColor;
    alayer.lineWidth = 4;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addLineToPoint:bPoint];
    [path addLineToPoint:endPoint];
    alayer.path = path.CGPath;
    [self.layer addSublayer:alayer];
}

/**
 *  阴影层
 */
- (CAShapeLayer *)shadowLayer
{
    if (!_shadowLayer) {
        _shadowLayer = [CAShapeLayer layer];
        _shadowLayer.path = [UIBezierPath bezierPathWithRect: SCREENBOUNDS].CGPath;
        _shadowLayer.fillColor = [UIColor colorWithWhite: 0 alpha: 0.75].CGColor;
        _shadowLayer.mask = self.maskLayer;
    }
    return _shadowLayer;
}

/**
 *  遮掩层
 */
- (CAShapeLayer *)maskLayer
{
    if (!_maskLayer) {
        _maskLayer = [CAShapeLayer layer];
        _maskLayer = [self generateMaskLayerWithRect: SCREENBOUNDS exceptRect: self.scanRect];
    }
    return _maskLayer;
}


#pragma mark - generate
/**
 *  生成空缺部分rect的layer
 */
- (CAShapeLayer *)generateMaskLayerWithRect: (CGRect)rect exceptRect: (CGRect)exceptRect
{
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    if (!CGRectContainsRect(rect, exceptRect)) {
        return nil;
    }
    else if (CGRectEqualToRect(rect, CGRectZero)) {
        maskLayer.path = [UIBezierPath bezierPathWithRect: rect].CGPath;
        return maskLayer;
    }
    
    CGFloat boundsInitX = CGRectGetMinX(rect);
    CGFloat boundsInitY = CGRectGetMinY(rect);
    CGFloat boundsWidth = CGRectGetWidth(rect);
    CGFloat boundsHeight = CGRectGetHeight(rect);
    
    CGFloat minX = CGRectGetMinX(exceptRect);
    CGFloat maxX = CGRectGetMaxX(exceptRect);
    CGFloat minY = CGRectGetMinY(exceptRect);
    CGFloat maxY = CGRectGetMaxY(exceptRect);
    CGFloat width = CGRectGetWidth(exceptRect);
    
    /** 添加路径*/
    UIBezierPath * path = [UIBezierPath bezierPathWithRect: CGRectMake(boundsInitX, boundsInitY, minX, boundsHeight)];
    [path appendPath: [UIBezierPath bezierPathWithRect: CGRectMake(minX, boundsInitY, width, minY)]];
    [path appendPath: [UIBezierPath bezierPathWithRect: CGRectMake(maxX, boundsInitY, boundsWidth - maxX, boundsHeight)]];
    [path appendPath: [UIBezierPath bezierPathWithRect: CGRectMake(minX, maxY, width, boundsHeight - maxY)]];
    maskLayer.path = path.CGPath;
    
    return maskLayer;
}


/**
 *  释放前停止会话
 */
- (void)dealloc
{
    //[self stop];
    AVAuthorizationStatus authorizationStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authorizationStatus == AVAuthorizationStatusAuthorized) {
        [self.session stopRunning];
        self.session = nil;
    }
}


#pragma mark - operate
/**
 *  开始视频会话
 */
- (void)start
{
    [self.session startRunning];
}

/**
 *  停止视频会话
 */
- (void)stop
{
    [self.session stopRunning];
    self.session = nil;
    [self removeFromSuperview];
    [self.delegate backHome];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
/**
 *  二维码扫描数据返回
 */
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0) {
        
        [self.session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = metadataObjects[0];
        if ([self.delegate respondsToSelector: @selector(sendMessageWithString:)]) {
            [self.delegate sendMessageWithString:metadataObject.stringValue];
            [self removeFromSuperview];
        }
    }
}


@end
