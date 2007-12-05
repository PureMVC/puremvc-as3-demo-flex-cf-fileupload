/*
 PureMVC Flex/CF Demo – File Uploader 
 Copyright (c) 2007 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.cf.fileupload.view
{
	import org.puremvc.patterns.mediator.Mediator;
	import org.puremvc.interfaces.IMediator;
	import org.puremvc.interfaces.INotification;
	
	import org.puremvc.as3.demos.flex.cf.fileupload.ApplicationFacade;
	import org.puremvc.as3.demos.flex.cf.fileupload.view.components.UploadForm;
	import org.puremvc.as3.demos.flex.cf.fileupload.model.FileReferenceProxy;
	import org.puremvc.as3.demos.flex.cf.fileupload.model.vo.ProgressVO;
	import org.puremvc.as3.demos.flex.cf.fileupload.view.managers.PopManager;
	
	import mx.controls.Alert;
	
	import flash.events.Event;

	public class UploadFormMediator extends Mediator implements IMediator
	{
		public static const NAME:String = 'UploadFormMediator';
		
		private var fileReferenceProxy:FileReferenceProxy; 
		
		public function UploadFormMediator( viewComponent:Object )
		{
			super( viewComponent );
			
			uploadForm.addEventListener( UploadForm.BROWSE, onBrowse );
			uploadForm.addEventListener( UploadForm.UPLOAD, onUpload );
			uploadForm.addEventListener( UploadForm.CANCEL, onCancel );
			uploadForm.addEventListener( UploadForm.CLOSE_POP, onClose );
		}
		
		override public function getMediatorName():String
		{
			return NAME;
		}
		
		public function get uploadForm():UploadForm
		{
			return viewComponent as UploadForm;
		}
		
		private function onBrowse( event:Event ):void
		{
			sendNotification( ApplicationFacade.FILE_BROWSE  );
		}
		
		private function onUpload( e:Event ):void
		{
			sendNotification( ApplicationFacade.FILE_UPLOAD  );
		}
		
		private function onCancel( event:Event ):void
		{
			sendNotification( ApplicationFacade.CANCEL_UPLOAD  );
	        resetUploader();
		} 
		
		private function onClose( e:Event ):void
		{
			resetUploader();
			PopManager.closePopUpWindow( uploadForm, NAME );
		}
		
		private function resetUploader():void
	    {
	    	
	    	uploadForm.mode = "";
	        uploadForm.f_name.text = "";
	        uploadForm.p_bar.label = "** Click Browse **";
	        uploadForm.p_bar.maximum = 0;
	        uploadForm.p_bar.minimum = 0;
	    }
	    
	    override public function listNotificationInterests():Array
		{
			return [
					ApplicationFacade.FILE_SELECTED,
					ApplicationFacade.PROGRESS,
					ApplicationFacade.RESET_FORM
				   ];
		}
		
		override public function handleNotification( note:INotification ):void
		{
			switch ( note.getName() )
			{
				case ApplicationFacade.FILE_SELECTED:
					 uploadForm.f_name.text = note.getBody() as String;
					 uploadForm.mode = UploadForm.MODE_UPLOAD;
					 uploadForm.p_bar.label = "** Click Upload **";
					 break;
					 
				case ApplicationFacade.PROGRESS:
					 var p:ProgressVO = note.getBody() as ProgressVO;
					 uploadForm.p_bar.setProgress( p.b_loaded, p.b_total );
					 uploadForm.p_bar.label = 
					 "Uploading " + Math.round( p.b_loaded / 1024 ) + 
					 " kb of " + Math.round( p.b_total / 1024 ) + " kb ";
					 break;
					 
				case ApplicationFacade.RESET_FORM:
					 resetUploader();
					 break;
			}
		}
		
	}
}