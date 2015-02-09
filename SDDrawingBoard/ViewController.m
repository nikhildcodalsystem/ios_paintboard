//
//  ViewController.m
//  SDDrawingBoard
//
//  Created by sdong on 2/7/15.
//  Copyright (c) 2015 SD. All rights reserved.
//

#import "ViewController.h"
#import "SettingsViewController.h"
#import <MessageUI/MessageUI.h>



@interface ViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate, MFMailComposeViewControllerDelegate>{
    
    CGPoint lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brush;
    CGFloat opacity;
    BOOL mouseSwiped;
}
@property (strong, nonatomic) UIImageView *mainImage;;
@property (strong, nonatomic) UIImageView *tempDrawImage;

@end


@implementation ViewController

-(UIImageView *)mainImage{
    if(!_mainImage){
        _mainImage = [[UIImageView alloc] init];
        [_mainImage setFrame:[[UIScreen mainScreen] bounds]];
    }
    return _mainImage;
}

-(UIImageView *)tempDrawImage{
    if(!_tempDrawImage){
        _tempDrawImage = [[UIImageView alloc] init];
        [_tempDrawImage setFrame:[[UIScreen mainScreen] bounds]];
    }
    return _tempDrawImage;
}

-(void)initResetAndSaveButton{
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    resetButton.frame = CGRectMake(self.view.frame.size.width/10, self.view.frame.size.height*0.35/10,
                                        self.view.frame.size.height*1.2/10, self.view.frame.size.width*1/10);
    [resetButton setTitle:@"Reset" forState:UIControlStateNormal];
    resetButton.backgroundColor = [UIColor colorWithRed: 0/255.0 green: 117/255.0 blue:94.0/255.0 alpha: 1.0];
    [resetButton setTintColor:[UIColor whiteColor]];

    resetButton.backgroundColor = [UIColor clearColor];
    [resetButton setTintColor:[UIColor colorWithRed: 0/255.0 green: 117/255.0 blue:94.0/255.0 alpha: 1.0]];

    resetButton.layer.cornerRadius = 10;
    resetButton.layer.masksToBounds = YES;
    resetButton.titleLabel.font = [UIFont systemFontOfSize:22];
    [resetButton addTarget:self  action:@selector(didPressResetButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetButton];
    
    UIButton* settingButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    settingButton.frame = CGRectMake(self.view.frame.size.width*4.5/10, self.view.frame.size.height*0.35/10,
                                  self.view.frame.size.width*1.2/10, self.view.frame.size.width*1/10);
    [settingButton setBackgroundImage:[UIImage imageNamed:@"gear.png"] forState:UIControlStateNormal];

    [settingButton addTarget:self  action:@selector(didPressSettingButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingButton];
    
    UIButton* saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    saveButton.frame = CGRectMake(self.view.frame.size.width*6.5/10, self.view.frame.size.height*0.35/10,
                                         self.view.frame.size.height*1.2/10, self.view.frame.size.width*1/10);
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    saveButton.backgroundColor = [UIColor colorWithRed: 0/255.0 green: 117/255.0 blue:94.0/255.0 alpha: 1.0];
    [saveButton setTintColor:[UIColor whiteColor]];
   
    saveButton.backgroundColor = [UIColor clearColor];
    [saveButton setTintColor:[UIColor colorWithRed: 0/255.0 green: 117/255.0 blue:94.0/255.0 alpha: 1.0]];

    saveButton.layer.cornerRadius = 10;
    saveButton.layer.masksToBounds = YES;
    saveButton.titleLabel.font = [UIFont systemFontOfSize:22];
    [saveButton addTarget:self  action:@selector(didPressSaveButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
}


-(void)didPressSettingButton:(id)sender{
    SettingsViewController * settingsVC = [[SettingsViewController alloc] init];
    settingsVC.delegate = self;
    [settingsVC SetPaint:brush opacity:opacity red:red green:green blue:blue];
    [self presentViewController:settingsVC animated:NO completion:nil];

}

-(void)didPressResetButton:(id)sender{
    //self.mainImage.image = nil;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Reset to white board",
                                                                      @"Reset background from album",
                                                                      @"Take a photo as background",
                                                                      @"Cancel", nil];
    actionSheet.tag = 1001;
    [actionSheet showInView:self.view];
}

-(void)didPressSaveButton:(id)sender{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Save to Camera Roll",
                                                                      @"Send to Message",
                                                                      @"Send to Email",
                                                                      @"Cancel",
                                                                      nil];
    actionSheet.tag = 1002;
    [actionSheet showInView:self.view];
}

-(void)initEraser{
    
    CGRect screenRect = [self.view bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.tag = 1000+100;
    [button addTarget:self
               action:@selector(pencilPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"E" forState:UIControlStateNormal];
    //button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    CGFloat buttonX = 10 * screenWidth / 12;
    CGFloat buttonY = 12 * screenHeight / 13;
    CGFloat buttonWidth = 2* screenWidth/12;
    CGFloat buttonHeight = screenHeight/11;
    
    [self setPencilButtonColor:button.tag];
    
    button.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
    button.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    [self.view addSubview:button];
    
}


-(void)initPaintPencil{
    
    //CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect screenRect = [self.view bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    for(int i=0; i<10; ++i){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.tag = 1000+i;
        [button addTarget:self
                   action:@selector(pencilPressed:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"" forState:UIControlStateNormal];
        //button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
        CGFloat buttonX = i * screenWidth / 12;
        CGFloat buttonY = 12 * screenHeight / 13;
        CGFloat buttonWidth = screenWidth/12;
        CGFloat buttonHeight = screenHeight/11;
        
        [self setPencilButtonColor:button.tag];
        
        button.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
        button.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
        [self.view addSubview:button];
    }
}

-(void)cleanButtonBorder:(int)i{
    UIButton * button = (UIButton *)[self.view viewWithTag:i];
    button.layer.borderColor=[[UIColor clearColor] CGColor];
}

-(void)cleanAllButtonBorder{
    for(int i=0; i<10; ++i){
        [self cleanButtonBorder:1000+i];
    }
}

-(void)highlightBorder:(UIButton*) button{
    button.layer.borderWidth=3.0f;
    button.layer.borderColor=[[UIColor whiteColor] CGColor];
}

-(void) setPencilButtonColor:(NSInteger)tag{
    switch(tag-1000)
    {
        case 0:
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            break;
        case 1:
            red = 105.0/255.0;
            green = 105.0/255.0;
            blue = 105.0/255.0;
            break;
        case 2:
            red = 255.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            break;
        case 3:
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 255.0/255.0;
            break;
        case 4:
            red = 102.0/255.0;
            green = 204.0/255.0;
            blue = 0.0/255.0;
            break;
        case 5:
            red = 102.0/255.0;
            green = 255.0/255.0;
            blue = 0.0/255.0;
            break;
        case 6:
            red = 51.0/255.0;
            green = 204.0/255.0;
            blue = 255.0/255.0;
            break;
        case 7:
            red = 160.0/255.0;
            green = 82.0/255.0;
            blue = 45.0/255.0;
            break;
        case 8:
            red = 255.0/255.0;
            green = 102.0/255.0;
            blue = 0.0/255.0;
            break;
        case 9:
            red = 255.0/255.0;
            green = 255.0/255.0;
            blue = 0.0/255.0;
            break;
        case 100:
            red = 255.0/255.0;
            green = 255.0/255.0;
            blue = 255.0/255.0;
            break;
    }
}

- (void)pencilPressed:(id)sender {
    [self cleanAllButtonBorder];
    UIButton * PressedButton = (UIButton*)sender;
    [self setPencilButtonColor:PressedButton.tag];
    [self highlightBorder:PressedButton];
}



-(void) initPencilColor{
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    brush = 10.0;
    opacity = 1.0;
    UIButton * button = (UIButton *)[self.view viewWithTag:1000];
    button.layer.borderColor=[[UIColor clearColor] CGColor];
    [self highlightBorder:button];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainImage];
    [self.view addSubview:self.tempDrawImage];
    [self initEraser];
    [self initPaintPencil];
    [self initPencilColor];
    [self initResetAndSaveButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempDrawImage setAlpha:opacity];
    UIGraphicsEndImageContext();
    
    lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    UIGraphicsBeginImageContext(self.mainImage.frame.size);
    [self.mainImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
    self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
    self.tempDrawImage.image = nil;
    UIGraphicsEndImageContext();
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - SettingsViewControllerDelegate methods

- (void)closeSettings:(id)sender {
    brush = ((SettingsViewController*)sender).brush;
    opacity = ((SettingsViewController*)sender).opacity;
    red = ((SettingsViewController*)sender).red;
    green = ((SettingsViewController*)sender).green;
    blue = ((SettingsViewController*)sender).blue;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag == 1001){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.delegate = self;
        
        if(buttonIndex == 0){
            self.mainImage.image = nil;

        }
        else if(buttonIndex == 1){
            picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            NSLog(@"pressed photo");
            [self presentViewController:picker animated:YES completion:nil];

        }
        
        else if(buttonIndex == 2){
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            NSLog(@"pressed camera");
            [self presentViewController:picker animated:YES completion:nil];

        }
    
    }
    else if(actionSheet.tag == 1002){
        if (buttonIndex == 0)
        {
            UIGraphicsBeginImageContextWithOptions(self.mainImage.bounds.size, NO,0.0);
            [self.mainImage.image drawInRect:CGRectMake(0, 0, self.mainImage.frame.size.width, self.mainImage.frame.size.height)];
            UIImage *SaveImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            UIImageWriteToSavedPhotosAlbum(SaveImage, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
        else if (buttonIndex == 1)
        {
            [self sendMsg];
        }
        else if (buttonIndex == 2)
        {
            [self sendEmail];
        }
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Image could not be saved.Please try again"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Image was successfully saved in photoalbum"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
        [alert show];
    }
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"Pressed use photo button");
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    if (!image) image = info[UIImagePickerControllerOriginalImage];

    self.mainImage.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"Pressed cancel button");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendMsg{
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    
    NSData *imgData = UIImageJPEGRepresentation(self.mainImage.image, 0.0);
    BOOL didAttachImage = [messageController addAttachmentData:imgData typeIdentifier:@"public.data"  filename:@"image.jpg"];
    
    
    if (didAttachImage)
    {
        // Present message view controller on screen
        [self presentViewController:messageController animated:YES completion:nil];
    }
    else
    {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                               message:@"Failed to attach image"
                                                              delegate:nil
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
}

- (void)sendEmail{
    
    NSString *emailTitle = @"";
    NSString *messageBody = @"";
    NSArray *toRecipents = [NSArray arrayWithObject:@""];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];

    NSData *imgData = UIImageJPEGRepresentation(self.mainImage.image, 0.0);
    // Add attachment
    [mc addAttachmentData:imgData mimeType:@"image/jpeg" fileName:@"image.img"];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
