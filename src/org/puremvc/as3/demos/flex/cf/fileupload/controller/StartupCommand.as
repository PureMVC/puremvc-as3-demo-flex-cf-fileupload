/*
 PureMVC Flex/CF Demo – File Uploader 
 Copyright (c) 2007-08 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.cf.fileupload.controller
{
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.interfaces.INotification;
	
	import org.puremvc.as3.demos.flex.cf.fileupload.ApplicationFacade;
	import org.puremvc.as3.demos.flex.cf.fileupload.model.FileReferenceProxy;
	import org.puremvc.as3.demos.flex.cf.fileupload.view.*;
	
	public class StartupCommand extends SimpleCommand implements ICommand
	{
		/**
		 * Register the Proxies and Mediators.
		 * 
		 * Get the View Components for the Mediators from the app,
		 * which passed a reference to itself on the notification.
		 */
		 override public function execute( note:INotification ):void
		 {
		 	
		 	var app:FileUpload = note.getBody() as FileUpload;
		 	
		 	facade.registerProxy( new FileReferenceProxy() );
			
			facade.registerMediator( new CanvasStageMediator( app.canvasStage ) );

		 }
	}
}