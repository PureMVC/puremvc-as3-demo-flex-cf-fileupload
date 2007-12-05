/*
 PureMVC Flex/CF Demo – File Uploader 
 Copyright (c) 2007 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.cf.fileupload.model
{
	import org.puremvc.interfaces.IProxy;
	import org.puremvc.patterns.proxy.Proxy;
	import org.puremvc.interfaces.INotification;
	
	import org.puremvc.as3.demos.flex.cf.fileupload.ApplicationFacade;
	import org.puremvc.as3.demos.flex.cf.fileupload.model.vo.ProgressVO;
	
	import flash.net.*;
	import flash.events.*;
	import flash.errors.IllegalOperationError;
	
	public class FileReferenceProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "FileReferenceProxy";
		
		// Set maximum file size for upload
		private static var maxFileSize:Number = 1500;
		
		/**
		 * Change to location of fileUpload.cfm on localhost or remote server!
		 */
		private static const UPLOAD_URL:String = "http://localhost:8101/cfusion/FlexUploader/cfc/fileUpload.cfm";
		
		public var fr:FileReference;
		private var ff:FileFilter;
		
		public function FileReferenceProxy()
		{
			super( NAME );
			
			filterFileType();
			
		}
		
		private function filterFileType():void
		{   
			ff = new FileFilter("Images (*.jpg; *.jpeg; *.gif; *.png)" ,"*.jpg; *.jpeg; *.gif; *.png");
		}
		
		public function fileBrowse():void
		{
			fr = new FileReference();
			
			fr.addEventListener( Event.CANCEL, cancelHandler );
			fr.addEventListener( Event.SELECT, selectHandler );
			fr.addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler );
            fr.addEventListener( ProgressEvent.PROGRESS, progressHandler );
            fr.addEventListener( Event.COMPLETE, completeHandler );
            
            try
				{
					fr.browse([ff]);
				}
				catch ( illegalOperation:IllegalOperationError )
				{
					sendNotification( ApplicationFacade.FR_ALERT, illegalOperation.type );
				}
		}
		
		public function fileUpload():void
		{
			var request:URLRequest = new URLRequest();
			request.url = UPLOAD_URL;
			
    		request.method = URLRequestMethod.POST;
    			
			fr.upload( request );
		}
		
		public function cancelUpload():void
		{
			fr.cancel();
		}
		
		private function cancelHandler( e:Event ):void
		{
			sendNotification( ApplicationFacade.FR_ALERT, e.type );
		}
		
		private function selectHandler( e:Event ):void
		{
			var fileSize:Number = Math.round( fr.size/1024 );
			
			if( fileSize <= maxFileSize )
			{
				sendNotification( ApplicationFacade.FILE_SELECTED, fr.name );	

			} else {
				var f_size:String = "FILE SIZE TO LARGE!\n\nPlease select a file smaller than "+ fileSize + "kb";
				sendNotification( ApplicationFacade.FR_ALERT, f_size );
			}
		}
		
		private function ioErrorHandler( e:Event ):void
		{
            sendNotification( ApplicationFacade.FR_ALERT, e );
		}
		
		private function progressHandler( e:ProgressEvent ):void
		{
			var progress:ProgressVO = new ProgressVO();
			progress.b_loaded = e.bytesLoaded;
			progress.b_total = e.bytesTotal;
			sendNotification( ApplicationFacade.PROGRESS, progress );
		}
		
		private function completeHandler( e:Event ):void
		{
			var file:FileReference = FileReference( e.target );
	        var fileName:String = file.name;
			
			sendNotification( ApplicationFacade.FR_ALERT, fileName );
		}
	}
}