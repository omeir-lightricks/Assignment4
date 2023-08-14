// Copyright (c) 2023 Lightricks. All rights reserved.
// Created by Ori Meir.

#import "PlayingCardView.h"

@interface PlayingCardView ()

@property (nonatomic) CGFloat faceCardScaleFactor;

@end

@implementation PlayingCardView

#pragma mark -
#pragma mark constants
#pragma mark -

const CGFloat kCornerRadius = 12.0;
const CGFloat kCornerFontStandartSize = 180.0;
const CGFloat kDefaultFaceCardScaleFactor = 0.9;

#pragma mark -
#pragma mark init
#pragma mark -

- (CGFloat)faceCardScaleFactor {
  if (!_faceCardScaleFactor) {
    _faceCardScaleFactor = kDefaultFaceCardScaleFactor;
  }
  return _faceCardScaleFactor;
}

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
#pragma mark setup and construcors
#pragma mark -

- (void)setSuit:(NSString *)suit {
  _suit = suit;
  [self setNeedsDisplay];
}

- (void)setRank:(NSUInteger)rank {
  _rank = rank;
  [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp {
  _faceUp = faceUp;
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

#pragma mark -
#pragma mark draw logic
#pragma mark -

- (NSString *)rankAsString {
  return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}

- (void)drawCorners {
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  paragraphStyle.alignment = NSTextAlignmentCenter;
  UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFactor]];

  NSAttributedString *cornerText = [[NSAttributedString alloc]
                                    initWithString:[NSString stringWithFormat:@"%@\n%@",
                                                    [self rankAsString], self.suit]
                                    attributes:@{NSFontAttributeName : cornerFont,
                                                 NSParagraphStyleAttributeName : paragraphStyle
                                               }];

  CGRect textBounds;
  textBounds.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
  textBounds.size = [cornerText size];
  [cornerText drawInRect:textBounds];

  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
  CGContextRotateCTM(context, M_PI);
  [cornerText drawInRect:textBounds];

}

- (void)drawRect:(CGRect)rect {


  UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                          cornerRadius:[self cornerRadius]];
  [roundedRect addClip];
  [[UIColor whiteColor] setFill];
  UIRectFill(self.bounds);
  [[UIColor blackColor] setStroke];
  [roundedRect stroke];


  NSString *imageName =[NSString stringWithFormat:@"%@%@", [self rankAsString], self.suit];
  UIImage *faceImage = [UIImage imageNamed:imageName];

  if (self.faceUp) {

    if (faceImage) {
      CGRect imageRect = CGRectInset(self.bounds,
                                     self.bounds.size.width * (1.0 - self.faceCardScaleFactor),
                                     self.bounds.size.height * (1.0 - self.faceCardScaleFactor));
      [faceImage drawInRect:imageRect];
    } else {
      [self drawPips];
    }

    [self drawCorners];

  } else {
    [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
  }


}

- (void)drawPips {

}

@end

