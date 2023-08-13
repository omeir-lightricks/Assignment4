// Copyright (c) 2023 Lightricks. All rights reserved.
// Created by Ori Meir.

#import "SetViewController.h"
#import "CGSetDeck.h"
#import "CGSetCard.h"

@interface SetViewController ()

@end

@implementation SetViewController

- (CGDeck *)resetDeck {
  return [[CGSetDeck alloc] init];
}

- (NSAttributedString *)lastCoiceResultsMessage:(NSInteger)pointsGiven {

  NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@""];
  [message appendAttributedString: [[NSAttributedString alloc]
                                    initWithString: pointsGiven > 0 ?
                                    @"are a set!\n" : @"are not a set!\n"]];

  [message appendAttributedString: [[NSAttributedString alloc]
                                    initWithString: pointsGiven > 0 ?
                                    @"1 point bonus" : @""]];

  return [[NSAttributedString alloc] initWithAttributedString:message];
}

- (UIImage *)backgroundImageForCard:(CGCard *)card {
  return [UIImage imageNamed: @"cardfront"];
}

- (UIColor *)getTextBackGroundColor:(CGCard *)card {
  return (card.isChosen && !card.isMatched) ? UIColor.greenColor : UIColor.whiteColor;
}

- (NSNumber *)getTextWidth:(CGCard *)card {
  return card.isMatched ? @5 : @0;
}

- (UIColor *)getCardColor:(CGSetCard *)card {
  UIColor *color = UIColor.greenColor;

  if (card.colorIdentifier == 1) {
    color = UIColor.blackColor;
  }
  if (card.colorIdentifier == 2) {
    color = UIColor.blueColor;
  }
  if (card.colorIdentifier == 3) {
    color = UIColor.redColor;
  }
  return color;
}

- (NSString *)titleForCard:(CGSetCard *)card showAnyway:(BOOL)showAnyway {
  NSString *cardShapesText = @"";

  for (int i = 0; i < card.amount; i++) {
    cardShapesText = [cardShapesText stringByAppendingString:@"Q"];
  }
  return cardShapesText;
}

- (BOOL)isThreeModeOn {
  return YES;
}

@end

