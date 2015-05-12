//
//  QRReaderViewController.swift
//  EliasContactApp
//
//  Created by Tucker Kirven on 5/7/15.
//  Copyright (c) 2015 Tucker Kirven. All rights reserved.
//

import UIKit
import AVFoundation

class QRReaderViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate
{
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    var QRStringRead:String?
    
    var addDecisionInProgress = false
    var active = false
    @IBAction func saveButton(sender: AnyObject) {
        if (QRStringRead!.substringWithRange(Range<String.Index>(start: QRStringRead!.startIndex, end: advance(QRStringRead!.startIndex, 3))) != "XYZ"){
            print("error")
        }
        if (QRStringRead != nil || QRStringRead != "{}"){
            
            appDelegate.contactList.add(LSContact(QRJSONString: QRStringRead!))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
        // as the media type parameter.
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        // Get an instance of the AVCaptureDeviceInput class using the previous device object.
        var error:NSError?
        let input: AnyObject! = AVCaptureDeviceInput.deviceInputWithDevice(captureDevice, error: &error)
        
        if (error != nil) {
            // If any error occurs, simply log the description of it and don't continue any more.
            println("\(error?.localizedDescription)")
            return
        }
        
        // Initialize the captureSession object.
        captureSession = AVCaptureSession()
        // Set the input device on the capture session.
        captureSession?.addInput(input as! AVCaptureInput)
        
        // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        
        // Set delegate and use the default dispatch queue to execute the call back
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer)
        
        // Start video capture.
        captureSession?.startRunning()
        
    
        
        // Initialize QR Code Frame to highlight the QR code
        qrCodeFrameView = UIView()
        qrCodeFrameView?.layer.borderColor = UIColor.greenColor().CGColor
        qrCodeFrameView?.layer.borderWidth = 2
        view.addSubview(qrCodeFrameView!)
        view.bringSubviewToFront(qrCodeFrameView!)
        
    }
    override func viewWillAppear(animated: Bool) {
        active = true
    }
    override func viewDidDisappear(animated: Bool) {
        active = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        if active {
            
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRectZero
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObjectTypeQRCode {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            qrCodeFrameView?.frame = barCodeObject.bounds;
            
            if metadataObj.stringValue != nil && !addDecisionInProgress {

                addDecisionInProgress = true
                var contact:LSContact?
                var QRStringRead = metadataObj.stringValue
                if (QRStringRead!.substringWithRange(Range<String.Index>(start: QRStringRead!.startIndex, end: advance(QRStringRead!.startIndex, 3))) != "XYZ"){
                    print("error")
                }
                if (QRStringRead != nil || QRStringRead != "{}"){
                    contact = LSContact(QRJSONString: QRStringRead!)
                    
                }
                
                let addMessage:String
                if (contact != nil  && contact?.get(Account: LSContact.Account.Name) != ""){
                    addMessage = "Would you like to add " + contact!.get(Account: LSContact.Account.Name) + "'s contact info?"
                }else{
                    addMessage = "Would you like to add this contact info?"
                }
                var alert = UIAlertController(title: "Add Contact", message: addMessage, preferredStyle: UIAlertControllerStyle.Alert)
                
                var addAction = UIAlertAction(title: "Add", style: UIAlertActionStyle.Default) {
                    UIAlertAction in
                    NSLog("OK Pressed")
                    self.appDelegate.contactList.add(contact!)
                    self.addDecisionInProgress = false
                }
                var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                    self.addDecisionInProgress = false
                }
                alert.addAction(addAction)
                alert.addAction(cancelAction)
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
        
        qrCodeFrameView?.frame = barCodeObject.bounds
    }
    }
}

