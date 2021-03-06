/*
 PureMVC Flex/CF Demo – File Uploader 
 Copyright (c) 2007-08 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.cf.fileupload.controller
{
	import org.puremvc.as3.demos.flex.cf.fileupload.ApplicationFacade;
	import org.puremvc.as3.demos.flex.cf.fileupload.model.FileReferenceProxy;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class BrowseCommand extends SimpleCommand implements ICommand
	{
		override public function execute( note:INotification ):void
		{
			var fileReferenceProxy:FileReferenceProxy = facade.retrieveProxy( FileReferenceProxy.NAME ) as FileReferenceProxy;
			
			fileReferenceProxy.fileBrowse();
		}
		
	}
}