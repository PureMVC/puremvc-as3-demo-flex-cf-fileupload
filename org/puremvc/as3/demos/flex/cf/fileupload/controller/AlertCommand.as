/*
 PureMVC Flex/CF Demo – File Uploader 
 Copyright (c) 2007 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.cf.fileupload.controller
{
	import org.puremvc.as3.demos.flex.cf.fileupload.ApplicationFacade;
	
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.command.SimpleCommand;
	
	import mx.controls.Alert;
	
	public class AlertCommand extends SimpleCommand implements ICommand
	{
		override public function execute( note:INotification ):void
		{
			var alert_string:String = note.getBody() as String;
			
			Alert.show( alert_string,"Upload Alert", Alert.OK );
			
			sendNotification( ApplicationFacade.RESET_FORM );
		}
		
	}
}