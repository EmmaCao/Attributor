//
//  TextStatsViewController.m
//  Attributor
//
//  Created by xhand on 2018/10/24.
//  Copyright © 2018年 Emma. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;
@end

@implementation TextStatsViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    
//    self.textToAnalyze = [[NSAttributedString alloc] initWithString:@"test" attributes:@{NSForegroundColorAttributeName:[UIColor greenColor], NSStrokeWidthAttributeName:@-3}];
//}

-(void)setTextToAnalyze:(NSAttributedString *)textToAnalyze
{
    _textToAnalyze = textToAnalyze;
    //如果页面还没有显示，则调用updateUI，避免与willAppear中的调用重复
    if (self.view.window) [self updateUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

-(void)updateUI
{
    self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%lu colorful characters", (unsigned long)[[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
    self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%lu outlined characters", (unsigned long)[[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];
}

-(NSAttributedString *)charactersWithAttribute:(NSString *)attributeName
{
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    
    NSInteger index = 0;
    while (index < [self.textToAnalyze length]){
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if (value) {
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = range.location + range.length;
        }else{
            index++;
        }
    }
    
    return characters;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
