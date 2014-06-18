//
//  SASViewController.m
//  Hesap Makinesi
//
//  Created by Şakir Şensoy on 16/06/14.
//  Copyright (c) 2014 Şakir Şensoy. All rights reserved.
//

#import "SASViewController.h"

@interface SASViewController ()

@end

@implementation SASViewController

// view yüklenirken
- (void)viewDidLoad
{
    // parent objedeki aynı metodu çalıştır
    [super viewDidLoad];
	
    // calculator objemizin bir instance'ını calculator
    // property'mize atayalım
    self.calculator = [[SASCalculator alloc] init];
    
    // varsayılan değerleri atayalım
    self.number1 = self.number2 = @"";
    self.screen.text = @"0";
    
    // ekran (sayıları gösteren label) font büyüklüğümüz
    // taşma yaşanmaması için ekran genişliğine göre optimize
    // edilsin
    self.screen.adjustsFontSizeToFitWidth = YES;
    
    // ses dosyamızın URL'ini bulalım
    NSString *soundFilePath = [NSString
                               stringWithFormat:@"%@/sound_effect.mp3",
                               [[NSBundle mainBundle] resourcePath]];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    // player'ı aktif hale getir
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// sayılara basılırsa
- (IBAction)numberButtonPressed:(id)sender
{
    UIButton *button = (UIButton *) sender;
    
    // ekrandaki sıfırı sil
    if ([self.screen.text isEqual:@"0"])
    {
        self.screen.text = @"";
    }
    
    // işlem operatörü atanmadıysa gelen değeri sayı1'e ata
    if (self.calculator.process == nil)
    {
        self.number1 = [self.number1 stringByAppendingString: button.currentTitle];
    }
    // işlem operatörü atandıysa gelen değeri sayı2'ye ata
    else
    {
        self.number2 = [self.number2 stringByAppendingString: button.currentTitle];
    }
    
    // ekranı yenile
    [self screenOrganize];
}

// işlem operatörlerine basılırsa
- (IBAction)processButtonPressed:(id)sender
{
    // sender değişkenini UIButton'a cast ederek
    // basılan button'a erişelim
    UIButton *button = (UIButton *) sender;
    
    // sayı1 boş değilse operatör atamasını gerçekleştirelim
    if (! [self.number1 isEqual:@""])
    {
        // basılan butonumuzun title'ı aslında operatörümüz
        // currentTitle ile operatörü alıyor ve calculator objemize
        // gerekli atamayı yapıyoruz
        self.calculator.process = button.currentTitle;
        
        // ekranı yenile
        [self screenOrganize];
    }
}

// sonuç butonuna basılırsa
- (IBAction)resultButtonPressed:(id)sender
{
    // sayı1, sayı2 ve işlem operatörü boş değilse
    if (! [self.number1 isEqual:@""] &&
        ! [self.number2 isEqual:@""] &&
        self.calculator.process != nil )
    {
        // sayı1 ve sayı2 adlı değişkenleri NSNumber'a cast ederek
        // calculator objemizdeki yerlerine ata
        self.calculator.number1 = (NSNumber *) self.number1;
        self.calculator.number2 = (NSNumber *) self.number2;
        
        // calculator objemizin result metodunu çalıştır ve sonucu
        // string olarak ekrana bastır
        self.screen.text = [[self.calculator result] stringValue];
        
        // temizlik
        self.number1 = self.number2 = @"";
        [self.calculator cancel];
        
        // bide ses efekti verelim ki, millet hesaplandığını anlasın :D
        [self.player play];
    }
}

// vazgeç butonuna basılırsa
- (IBAction)cancelButtonPressed:(id)sender
{
    [self cancelProcess];
}

// hesap makinesini sıfırla
- (void)cancelProcess
{
    // değerleri boşalt
    self.number1 = self.number2 = @"";
    [self.calculator cancel];
    
    // ekranı sıfırla
    self.screen.text = @"0";
}

// ekranımızı organize eden metodumuz
- (void)screenOrganize
{
    NSString *screenText = @"";
    
    // sayı 1 boş değilse
    if (! [self.number1 isEqual:@""])
    {
        // ekrandaki yazıya ekle
        screenText = [screenText stringByAppendingString: self.number1];
        
        // işlem operatörü boş değilse
        if (self.calculator.process != nil)
        {
            // önce alt satıra geç
            screenText = [screenText stringByAppendingString: @"\n"];
            
            // ve ekrana operatörü ekle
            screenText = [screenText stringByAppendingString: self.calculator.process];
            
            if (! [self.number2 isEqual:@""])
            {
                screenText = [screenText stringByAppendingString: @"\n"];
                screenText = [screenText stringByAppendingString: self.number2];
            }
        }
    }
    
    // ekrandaki metini güncelle
    self.screen.text = screenText;
}

// dokunmaları yakala
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    // sadece çift dokunmaları yakalıyoruz
    if (touch.tapCount == 2)
    {
        // dokunulan yerin koordinatları, label'ın alanı içinde kalıyorsa
        // ekranı sıfırla
        if (CGRectContainsPoint([self.screen frame], [touch locationInView:self.view]))
        {
            [self cancelProcess];
        }
    }
}

// hareketleri yakala
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    // sadece çalkalama hareketini yakala ve ekranı sıfırla
    if (motion == UIEventSubtypeMotionShake)
    {
        [self cancelProcess];
    }
}
@end
