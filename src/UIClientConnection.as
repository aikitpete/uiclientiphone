/*
 * Created by IntelliJ IDEA.
 * User: Peter Gerhat
 * Date: May 27, 2010
 * Time: 4:04:13 PM
 * To change this template use File | Settings | File Templates.
 */
package {
import uiclient.*;

import configurationreader.*;

import flash.events.*;
import flash.net.XMLSocket;
import flash.system.fscommand;

import mx.controls.Alert;

import reader.*;

import utils.XMLTools;

public class UIClientConnection {

    private static var xmlIn:XML;
    private static var xmlOut:XML;
    private static var clientSocket:XMLSocket;

    /**
     * Sends XML to server
     * @param xml
     */
    public static function send(xml:XML):void {
        UIClient.debug("Event sent to server");
        clientSocket.send(xml);                     //sends the xml to server

        //UIClient.debug(xml.toXMLString()+"\n");   //displays sent xml in console
    }

    public static function init():void {
        loadDefaultModels();
    }

    /**
     * Loads default application model
     */
    private static function loadDefaultModels():void {
        ConfigurationReader.getDefaultXML(ObjectType.DEFAULT_MODEL, "public.application", loadConnectXML);  //loads application model
    }

    /**
     * Loads connect XML
     * @param xml
     */
    private static function loadConnectXML(xml:XML):void {
        UIDocumentReader.readModels(xml);
        ConfigurationReader.getDefaultXML(ObjectType.DEFAULT_XML, "public.connection.connect", initConnection); //loads connect xml
    }

    private static function initConnection(xml:XML):void {
        xmlOut = xml;

        //used when connecting to a policy server to get policy file
        //connect(ConfigurationReader.policyServerHost, ConfigurationReader.policyServerPort); //connect to policy server
        //clientSocket.close();

        connect(ConfigurationReader.uiServerHost, ConfigurationReader.uiServerPort); //connect to UI server
    }

    private static function connect(host:String, port:Number):void {
        UIClient.setStatus(ClientStatus.CONNECTING);
        clientSocket = new XMLSocket();
        configureListeners(clientSocket);
        clientSocket.connect(host, port);
    }

    /**
     * Configures listeners for connection events
     * @param dispatcher
     */
    private static function configureListeners(dispatcher:IEventDispatcher):void {
        dispatcher.addEventListener(Event.CLOSE, closeHandler);
        dispatcher.addEventListener(Event.CONNECT, connectHandler);
        dispatcher.addEventListener(DataEvent.DATA, dataHandler);
        dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
        dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
    }

    private static function closeHandler(event:Event):void {
        trace("closeHandler: ");
        UIClient.setStatus(ClientStatus.DISCONNECTED);
    }

    private static function connectHandler(event:Event):void {
        trace("connectHandler: ");
        UIClient.setStatus(ClientStatus.CONNECTED);
        clientSocket.send(xmlOut);
    }

    private static function dataHandler(event:DataEvent):void {
        trace("dataHandler: ");
        UIClient.debug("Data received");
        //@todo end connection
        xmlIn = XMLTools.validateXML(xmlIn, event.data);
        if (xmlIn != null) {
            UIClient.debug("XML is valid");
            //UIClient.debug("Received:\n"+xmlIn+"\n");
            UIDocumentReader.processDocument(xmlIn);
        }
        else {
            UIClient.debug("XML is not valid");
        }
    }

    private static function ioErrorHandler(event:IOErrorEvent):void {
        trace("ioErrorHandler: ");
        UIClient.debug("IOERROR");
        UIClient.setStatus(ClientStatus.DISCONNECTED);
        Alert.show("Can't connect to server.");
        fscommand("quit");
    }

    private static function progressHandler(event:ProgressEvent):void {
        trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
        UIClient.debug("PROGRESS");
    }

    private static function securityErrorHandler(event:SecurityErrorEvent):void {
        trace("securityErrorHandler: ");
        UIClient.debug("SECURITYERROR");
    }


}
}