// Copyright (c) 2023 Lightricks. All rights reserved.
// Created by Ori Meir.

#import <Foundation/Foundation.h>
#import "SetCardView.h"
#import "CGSetCard.h"

@interface SetCardView ()


@end

@implementation SetCardView

#pragma mark -
#pragma mark constants
#pragma mark -

const CGFloat kCornerRadius = 12.0;
const CGFloat kCornerFontStandartSize = 180.0;
const CGFloat kHalfCurveWidthPart = 8;
const CGFloat kHalfCurveHightPart = 16;
const CGFloat kSquiggleHightPart = 9;

#pragma mark -
#pragma mark init
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

- (UIBezierPath *)drawSquiggleAtPoint:(CGPoint)startPoint {

  CGFloat halfCurveWidth = self.bounds.size.width / kHalfCurveWidthPart;
  CGFloat curveHight = self.bounds.size.height / kHalfCurveHightPart;
  CGFloat squiggleHight = self.bounds.size.height / kSquiggleHightPart;

  UIBezierPath *path = [[UIBezierPath alloc] init];
  startPoint = CGPointMake(startPoint.x, startPoint.y - squiggleHight / 2);
  [path moveToPoint:startPoint];

  [path addQuadCurveToPoint:CGPointMake(startPoint.x + 2 * halfCurveWidth,
                                        startPoint.y)
               controlPoint:CGPointMake(startPoint.x + halfCurveWidth,
                                        startPoint.y + curveHight)];
  [path addQuadCurveToPoint:CGPointMake(startPoint.x + 4 * halfCurveWidth,
                                        startPoint.y)
               controlPoint:CGPointMake(startPoint.x + 3 * halfCurveWidth,
                                        startPoint.y - curveHight)];

  CGPoint lowerSquigglePoint = CGPointMake(startPoint.x + 4 * halfCurveWidth,
                                           startPoint.y + squiggleHight);

  [path addLineToPoint:lowerSquigglePoint];

  [path addQuadCurveToPoint:CGPointMake(lowerSquigglePoint.x - 2 * halfCurveWidth,
                                        lowerSquigglePoint.y)
               controlPoint:CGPointMake(lowerSquigglePoint.x - halfCurveWidth,
                                        lowerSquigglePoint.y - curveHight)];
  [path addQuadCurveToPoint:CGPointMake(lowerSquigglePoint.x - 4 * halfCurveWidth,
                                        lowerSquigglePoint.y)
               controlPoint:CGPointMake(lowerSquigglePoint.x - 3 * halfCurveWidth,
                                        lowerSquigglePoint.y + curveHight)];

  [path closePath];
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

  [self drawShapesByAmount];
}

- (void)drawCorners {
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  paragraphStyle.alignment = NSTextAlignmentCenter;
}

@end

