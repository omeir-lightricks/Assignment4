// Copyright (c) 2023 Lightricks. All rights reserved.
// Created by Ori Meir.

#import "SetCardView.h"
#import <Foundation/Foundation.h>

@interface SetCardView ()


@end

@implementation SetCardView

const CGFloat kCornerRadius = 12.0;
const CGFloat kCornerFontStandartSize = 180.0;

#pragma mark -
#pragma mark setup and construcors
#pragma mark -

- (void)setUp {
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib {
  [super awakeFromNib];
  [self setUp];
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {

  }
  return self;
}

#pragma mark -
#pragma mark setters and getters
#pragma mark -

- (void)setFillIdentifier:(NSInteger)fillIdentifier {
  _fillIdentifier = fillIdentifier;
  [self setNeedsDisplay];
}

- (void)setShapeIdentifier:(NSInteger)shapeIdentifier {
  _shapeIdentifier = shapeIdentifier;
  [self setNeedsDisplay];
  }

- (void)setColorIdentifier:(NSInteger)colorIdentifier {
  _colorIdentifier = colorIdentifier;
  [self setNeedsDisplay];
}

- (void)setAmount:(NSInteger)amount {
  _amount = amount;
  [self setNeedsDisplay];
}

#pragma mark -
#pragma mark draw parameters calculations
#pragma mark -

- (CGFloat)cornerScaleFactor {
  return self.bounds.size.height / kCornerFontStandartSize;
}

- (CGFloat)cornerRadius {
  return kCornerRadius * [self cornerScaleFactor];
}

- (CGFloat)cornerOffset {
  return  [self cornerRadius] / 3.0;
}

- (NSMutableArray<NSValue *> *)calculateShapesStartPoints {
  NSMutableArray<NSValue *> * startPoints = [[NSMutableArray<NSValue *> alloc] init];
  for (int i = 1; i <= self.amount; i++) {
    [startPoints addObject:
     [NSValue valueWithCGPoint:CGPointMake(self.bounds.size.width / 4, self.bounds.size.height * i / (self.amount + 1))]];
  }
  return startPoints;
}

#pragma mark -
#pragma mark draw logic
#pragma mark -

- (void)drawColor:(UIBezierPath *)shapePath {
  UIColor *color = [UIColor whiteColor];
  switch (self.colorIdentifier) {
    case 1:
      color = [UIColor greenColor];
      break;
    case 2:
      color = [UIColor purpleColor];
      break;
    case 3:
      color = [UIColor redColor];
      break;
    default:
      break;
  }
  [color setStroke];
  [color setFill];
}

- (void)fillWithStripes:(UIBezierPath *)shapePath {
  UIBezierPath *stripes = [UIBezierPath bezierPath];

  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  [shapePath addClip];

  CGPoint shapeStartPoint = shapePath.bounds.origin;
  NSInteger shapeWidth = shapePath.bounds.size.width;
  NSInteger shapeHight = shapePath.bounds.size.height;

  for (int x = 0; x < shapeWidth; x += 5 ) {
    [stripes moveToPoint:CGPointMake(shapeStartPoint.x + x, shapeStartPoint.y)];
    [stripes addLineToPoint:CGPointMake(shapeStartPoint.x + x, shapeStartPoint.y +shapeHight)];
  }
  [stripes setLineWidth:1];
  [stripes stroke];

  CGContextRestoreGState(context);
}

- (void)drawFill:(UIBezierPath *)shapePath {
  switch (self.fillIdentifier) {
    case 1:
      [shapePath fill];
      break;
    case 2:
      [self fillWithStripes:shapePath];
      break;
    default:
      break;
  }
}

- (UIBezierPath *)drawDiamond:(CGPoint)startPoint {
  UIBezierPath *shapePath = [UIBezierPath bezierPath];
  [shapePath moveToPoint:startPoint];
  [shapePath addLineToPoint:CGPointMake(self.bounds.size.width / 2, startPoint.y + self.bounds.size.height / 9)];
  [shapePath addLineToPoint:CGPointMake(self.bounds.size.width * 3 / 4, startPoint.y)];
  [shapePath addLineToPoint:CGPointMake(self.bounds.size.width / 2, startPoint.y - self.bounds.size.height / 9)];
  [shapePath closePath];

//  [[UIColor blueColor] setStroke];
//  [shapePath stroke];
  return shapePath;
}

- (UIBezierPath *)drawOval:(CGPoint)startPoint {
  UIBezierPath *shapePath = [UIBezierPath bezierPathWithOvalInRect:
                             CGRectMake(startPoint.x,
                                        startPoint.y - self.bounds.size.height / 12,
                                        self.bounds.size.width / 2,
                                        self.bounds.size.height * 2 / 12)];
  return shapePath;
}

#define SQUIGGLE_WIDTH 0.12
#define SQUIGGLE_HEIGHT 0.3
#define SQUIGGLE_FACTOR 0.8
#define SYMBOL_LINE_WIDTH 2

- (UIBezierPath *)drawSquiggleAtPoint:(CGPoint)startPoint {
  CGFloat dx = self.bounds.size.width * SQUIGGLE_WIDTH / 2.0;
  CGFloat dy = self.bounds.size.height * SQUIGGLE_HEIGHT / 2.0;
  CGFloat dsqx = dx * SQUIGGLE_FACTOR;
  CGFloat dsqy = dy * SQUIGGLE_FACTOR;

  UIBezierPath *path = [[UIBezierPath alloc] init];
  [path moveToPoint:CGPointMake(startPoint.x - dx, startPoint.y - dy)];
  [path addQuadCurveToPoint:CGPointMake(startPoint.x + dx, startPoint.y - dy)
               controlPoint:CGPointMake(startPoint.x - dsqx, startPoint.y - dy - dsqy)];
  [path addCurveToPoint:CGPointMake(startPoint.x + dx, startPoint.y + dy)
          controlPoint1:CGPointMake(startPoint.x + dx + dsqx, startPoint.y - dy + dsqy)
          controlPoint2:CGPointMake(startPoint.x + dx - dsqx, startPoint.y + dy - dsqy)];
  [path addQuadCurveToPoint:CGPointMake(startPoint.x - dx, startPoint.y + dy)
               controlPoint:CGPointMake(startPoint.x + dsqx, startPoint.y + dy + dsqy)];
  [path addCurveToPoint:CGPointMake(startPoint.x - dx, startPoint.y - dy)
          controlPoint1:CGPointMake(startPoint.x - dx - dsqx, startPoint.y + dy - dsqy)
          controlPoint2:CGPointMake(startPoint.x - dx + dsqx, startPoint.y - dy + dsqy)];
  [path closePath];
  path.lineWidth = self.bounds.size.width * SYMBOL_LINE_WIDTH;

  return path;
}

- (UIBezierPath *)drawShape:(CGPoint)startPoint {
  switch (self.shapeIdentifier) {
    case 1:
      return [self drawDiamond:startPoint];
    case 2:
      return [self drawOval:startPoint];
    case 3:
      return [self drawSquiggleAtPoint:startPoint];
    default:
      return nil;
  }

}

- (void)drawShapesByAmount {

  NSMutableArray<NSValue *> * startPoints =  [self calculateShapesStartPoints];

  for (NSValue *startPointValue in startPoints) {
    CGPoint startPoint = [startPointValue CGPointValue];
    UIBezierPath *shapePath = [self drawShape:startPoint];
    [self drawColor:shapePath];
    [self drawFill:shapePath];
    [shapePath stroke];
  }
}

- (void)drawRect:(CGRect)rect {
  UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                          cornerRadius:[self cornerRadius]];
  [roundedRect addClip];

  [[UIColor whiteColor] setFill];
  UIRectFill(self.bounds);

  [[UIColor blackColor] setStroke];
  [roundedRect stroke];
  self.shapeIdentifier = 3;
  self.amount = 1;
  self.fillIdentifier = 1;
  self.colorIdentifier = 3;

  [self drawShapesByAmount];
}

- (void)drawCorners {
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  paragraphStyle.alignment = NSTextAlignmentCenter;
}

@end

