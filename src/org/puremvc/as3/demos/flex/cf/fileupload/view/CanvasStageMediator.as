/*
 PureMVC Flex/CF Demo – File Uploader 
 Copyright (c) 2007 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.cf.fileupload.view
{
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	
	import org.puremvc.as3.demos.flex.cf.fileupload.ApplicationFacade;
	import org.puremvc.as3.demos.flex.cf.fileupload.view.components.CanvasStage;
	import org.puremvc.as3.demos.flex.cf.fileupload.view.components.UploadForm;
	import org.puremvc.as3.demos.flex.cf.fileupload.view.UploadFormMediator;
	import org.puremvc.as3.demos.flex.cf.fileupload.view.managers.PopManager;

	import flash.events.Event;

	public class CanvasStageMediator extends Mediator implements IMediator
	{
		public static const NAME:String = 'CanvasStageMediator';
		
		public function CanvasStageMediator( viewComponent:Object )
		{
			super( NAME, viewComponent );
			
			canvasStage.addEventListener( CanvasStage.OPEN, onOpen );
		}
		
		public function get canvasStage():CanvasStage
		{
			return viewComponent as CanvasStage;
		}
		
		private function onOpen( e:Event ):void
		{
			PopManager.openPopUpWindow( UploadForm, UploadFormMediator );
		}
		
	}
}