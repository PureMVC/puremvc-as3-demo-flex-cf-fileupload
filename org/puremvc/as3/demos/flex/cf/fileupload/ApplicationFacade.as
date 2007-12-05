/*
 PureMVC Flex/CF Demo – File Uploader 
 Copyright (c) 2007 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
 
package org.puremvc.as3.demos.flex.cf.fileupload
{
	import org.puremvc.interfaces.IFacade;
	import org.puremvc.patterns.facade.Facade;
	import org.puremvc.patterns.observer.Notification;
	
	import org.puremvc.as3.demos.flex.cf.fileupload.controller.*;

	public class ApplicationFacade extends Facade implements IFacade
	{
		/**
		 * Notification name constants
		 */
		 public static const STARTUP:String         = "startUp";
		 public static const CANCEL_UPLOAD:String   = "cancelUpload";
		 public static const FILE_BROWSE:String     = "fileBrowse";
		 public static const FILE_SELECTED:String   = "fileSelected";
		 public static const FILE_UPLOAD:String     = "fileUpload";
		 public static const FR_ALERT:String        = "frAlert";
		 public static const RESET_FORM:String      = "resetForm";
		 public static const PROGRESS:String        = "progress";
		 
		/**
		 * Singleton ApplicationFacade Factory Method
		 */
		public static function getInstance():ApplicationFacade
		{
			if ( instance == null ) instance = new ApplicationFacade();
			return instance as ApplicationFacade;
		}
		
		public function startup( app:Demo_AS3_Flex_CF_FileUpload ):void
		{
			notifyObservers( new Notification( STARTUP, app ) );
		}
		
		override protected function initializeController():void
		{
			super.initializeController();
			
			registerCommand( STARTUP, StartupCommand );
			
			registerCommand( CANCEL_UPLOAD, CancelCommand );
			registerCommand( FILE_BROWSE, BrowseCommand );
			registerCommand( FILE_UPLOAD, UploadCommand );
			registerCommand( FR_ALERT, AlertCommand );
			
		}
	}
}