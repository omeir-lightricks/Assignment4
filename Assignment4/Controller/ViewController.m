//
//  ViewController.m
//  Matchismo
//
//  Created by Ori Meir on 31/07/2023.
//

#import "ViewController.h"
#import "CGCardMatchEngineGame.h"
#import "cardView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *cardsScreen;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cards;
@property (strong, nonatomic)  NSMutableArray<cardView *> *cardsViews;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *TapOnCard;

@property (nonatomic) BOOL cardsGrouped;
@property (nonatomic) NSInteger score;
@property (nonatomic) NSInteger flipCount;
@property (nonatomic) BOOL threeModeOn;
@property (strong, nonatomic) CGDeck *deck;
@property (strong, nonatomic) CGCardMatchEngineGame *game;

@end

@implementation ViewController

# pragma mark -
# pragma mark constants
# pragma mark -

const CGFloat kCardsColumnsNumber = 4.0;
const CGFloat kCardsLineNumber = 3.0;
const CGFloat kStartPointDistance = 60;
const CGFloat kAnimationTime = 0.5;
const NSInteger kBasicCardsAmount = 12;
const NSInteger kMaxCardsAmount = 16;

# pragma mark -
# pragma mark UIViewController methods override
# pragma mark -

- (void)viewDidLoad {
  _cardsGrouped = NO;
  [self updateUI];
}

# pragma mark -
# pragma mark setters and getters
# pragma mark -

- (void)setScore:(NSInteger)score {
  _score = score;
  self.scoreLabel.text = [NSString stringWithFormat: @"Score: %ld", score];
}

- (CGDeck *)deck {
  if (!_deck) {
    _deck = [self resetDeck];
  }
  return _deck;
}

- (CGCardMatchEngineGame *)game {
  if (!_game) {
    [self resetGame];
  }
  return _game;
}

- (BOOL)isThreeModeOn {
  return nil;
}

# pragma mark -
# pragma mark cards screen section logic
# pragma mark -

- (cardView *)getNewCardView:(CGCard *)card {
  return nil;
}

- (CGRect)findBound {
  CGFloat width = _cardsScreen.bounds.size.width / 7;
  CGFloat height = _cardsScreen.bounds.size.height / 6;
  return CGRectMake(0, 0, width, height);
}

- (CGPoint)findCenterForCard:(cardView *)card {
  NSInteger index = [self.cardsViews indexOfObject:card];
  CGFloat xCoordinate = (1 + index % (NSInteger) kCardsColumnsNumber) / (kCardsColumnsNumber + 1) * _cardsScreen.bounds.size.width;
  CGFloat yCoordinate = (1 + index / (NSInteger) kCardsColumnsNumber) / (kCardsColumnsNumber + 1) * _cardsScreen.bounds.size.height;
  return CGPointMake(xCoordinate, yCoordinate);
}

- (void)updateCardState:(CGCard *)card view:(cardView *)view {
  view.chosen = card.chosen;
}

- (void)updateCardsProperties {
  if (!_cardsViews) {
    return;
  }
  for (cardView *view in _cardsViews) {
    CGCard *card = [self.game cardAtIndex:[_cardsViews indexOfObject:view]];
    [self updateCardState:card view:view];
    view.removedFromView = card.matched;
  }
}

- (void)createViewForCard:(CGCard *)card {
  cardView *newCardView = [self getNewCardView:card];
  [_cardsViews addObject:newCardView];

  CGPoint cardsStartPoint = CGPointMake(_cardsScreen.bounds.origin.x - kStartPointDistance,
                                        _cardsScreen.bounds.origin.y);
  CGPoint cardDestination = [self findCenterForCard:newCardView];

  newCardView.bounds = [self findBound];
  newCardView.center = cardsStartPoint;
  [_cardsScreen addSubview:newCardView];

  [UIView animateWithDuration:kAnimationTime
                   animations:^{newCardView.center = cardDestination;}];
}

- (void)removeViewForCard:(cardView *)view {

  CGPoint cardDestination = CGPointMake(_cardsScreen.bounds.origin.x +
                                        _cardsScreen.bounds.size.width + kStartPointDistance,
                                        _cardsScreen.bounds.origin.y +
                                        _cardsScreen.bounds.size.height + kStartPointDistance);
  [UIView animateWithDuration:kAnimationTime
                   animations:^{view.center = cardDestination;}
                   completion:^(BOOL finished) {
    [view removeFromSuperview];
  }];
}

- (void)updateCardsViews {
  if (!_cardsViews) {
    _cardsViews = [[NSMutableArray alloc] init];
    for (CGCard *card in self.game.cards) {
      [self createViewForCard:card];
    }
  }

  for (cardView *view in _cardsViews) {
    if (view.removedFromView) {
      [self removeViewForCard:view];
    }
  }
}

- (void)hideAllCards {
  for (cardView *view in _cardsViews) {
    [self removeViewForCard:view];
  }

  self.cardsViews = nil;
}

# pragma mark -
# pragma mark buttons actions
# pragma mark -

- (IBAction)newGame:(UIButton *)sender {
  NSInteger initialScore = 0;
  [self setScore:initialScore];
  self.deck = [self resetDeck];
  [self hideAllCards];
  [self resetGame];
  [self updateCardsViews];
}

- (void)resetGame {
  _game = [[CGCardMatchEngineGame alloc]
           initWithCardCount:kBasicCardsAmount
           usingDeck:self.deck];
  [_game setThreeMode:[self isThreeModeOn]];
  [self updateUI];
}

- (CGDeck *)resetDeck {
  return nil;
}

- (IBAction)dealMore:(id)sender {
  while ([self.game.cards count] < kMaxCardsAmount) {
    CGCard *newCard = [_game dealMore:self.deck];
    [self createViewForCard:newCard];
  }
}

- (IBAction)handleSingleTap:(UITapGestureRecognizer *)recognizer {

  if (_cardsGrouped) {
    _cardsGrouped = NO;
    for (cardView *card in self.cardsViews) {
      [UIView animateWithDuration:kAnimationTime
                       animations:^{card.center = [self findCenterForCard:card];}];
    }
  }

  CGPoint tapLocation = [recognizer locationInView:[recognizer.view superview]];
  tapLocation = CGPointMake(tapLocation.x, tapLocation.y - _cardsScreen.frame.origin.y);

  for (cardView *view in self.cardsViews) {
    if (CGRectContainsPoint(view.frame, tapLocation) && !view.removedFromView) {
      NSUInteger chosenButtonIndex = [self.cardsViews indexOfObject:view];
      [self.game chooseCardAtIndex:chosenButtonIndex];
      [self updateUI];
      break;
    }
  }
}

- (IBAction)handleGroupedCardsMovement:(id)sender {
  UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveGroupedCards:)];
  panRecognizer.minimumNumberOfTouches = 1;
  for (cardView *view in self.cardsViews) {
    [view addGestureRecognizer:panRecognizer];
  }

}

-(void)moveGroupedCards:(UIPanGestureRecognizer*)sender {
  for (cardView *view in self.cardsViews) {
    view.center = [sender locationInView:_cardsScreen];
  }
}

- (IBAction)handlePinch:(id)recognizer {
    if (_cardsGrouped) {
      return;
    }
    _cardsGrouped = YES;
    CGPoint cardSectorCener = _cardsScreen.center;
    for (cardView *card in self.cardsViews) {
      [UIView animateWithDuration:kAnimationTime
                       animations:^{card.center = cardSectorCener;}];
    }
}

- (void)updateUI {
  [self updateCardsProperties];
  [self setScore:self.game.score];
  [self updateCardsViews];
}


@end
