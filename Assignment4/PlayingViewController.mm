// Copyright (c) 2023 Lightricks. All rights reserved.
// Created by Ori Meir.

#import "PlayingViewController.h"
#import "CGPlayingCardDeck.h"

@interface PlayingViewController ()

@end

@implementation PlayingViewController : ViewController

- (NSAttributedString *)lastCoiceResultsMessage:(NSInteger)pointsGiven {
  NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@""];

  [message appendAttributedString:[[NSAttributedString alloc] initWithString:
                                   pointsGiven > 0 ? @"are good choice!\n" : @"are bad choice!\n"]];
  [message appendAttributedString:[[NSAttributedString alloc] initWithString:
                                   [NSString localizedStringWithFormat:@"%ld points ", pointsGiven]]];
  [message appendAttributedString:[[NSAttributedString alloc] initWithString:
                                    pointsGiven > 0 ? @"bonus" : @"penalty"]] ;

  return message;
}

- (CGDeck *)resetDeck {
  return [[CGPlayingCardDeck alloc] init];
}

- (BOOL)isThreeModeOn {
  return NO;
}

- (NSNumber *)getTextWidth:(CGCard *)card {
  return card.isMatched ? @1 : @7;
}

- (NSString *)titleForCard:(CGCard *)card showAnyway:(BOOL)showAnyway {
  // TODO: fix this function
  return card.isChosen || card.isMatched || showAnyway ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(CGCard *)card {
  return [UIImage imageNamed:card.isChosen || card.isMatched  ? @"cardfront" : @"cardback"];
}

@end

