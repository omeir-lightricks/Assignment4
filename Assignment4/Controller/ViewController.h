//
//  ViewController.h
//  MacthismoGame
//
//  Created by Ori Meir on 02/08/2023.
//

#import <UIKit/UIKit.h>
#import "CGDeck.h"
#import "cardView.h"

@interface ViewController : UIViewController

//  The next methods are abstract, and must be implemented in every subclass:

//  Return object inherit from CGDeck, with a new full deck
// - (CGDeck *)resetDeck;
//  Create a card view with all the relevant properties card object contains
// - (cardView *)getNewCardView:(CGCard *)card;
//  This method return YES if match in thus game shuld be checked on 3 cards, else NO
// - (BOOL)isThreeModeON;

@end

