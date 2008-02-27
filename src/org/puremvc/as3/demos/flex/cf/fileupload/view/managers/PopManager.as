/*
 PureMVC Flex/CF Demo – File Uploader 
 Copyright (c) 2007 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.cf.fileupload.view.managers
{
	import mx.core.Application;
	import flash.display.Sprite;
	import mx.managers.PopUpManager;
	import mx.core.IFlexDisplayObject;
	import org.puremvc.as3.demos.flex.cf.fileupload.ApplicationFacade;
	
	public class PopManager extends PopUpManager
	{
		public static function openPopUpWindow( ComponentClass:Class, MediatorClass:Class ):void
		{
			var window:IFlexDisplayObject = PopUpManager.createPopUp( Application.application as Sprite, ComponentClass, true );
		
			ApplicationFacade.getInstance().registerMediator( new MediatorClass( window ) );
			PopUpManager.centerPopUp( window );
		}
		
		public static function closePopUpWindow( window:IFlexDisplayObject, mediatorName:String ):void
		{
			PopUpManager.removePopUp( window );
			ApplicationFacade.getInstance().removeMediator( mediatorName );
		}
		
	}
}