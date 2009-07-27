﻿/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2009
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
*/

package system.logging
{
    import system.events.LoggerEvent;

    import flash.events.EventDispatcher;

    /**
     * The logger that is used within the logging framework. This class dispatches events for each message logged using the log() method.
     */
    internal class InternalLogger extends EventDispatcher implements Logger
    {
        /**
         * Creates a new LogLogger instance.
         * @param channel The channel value of the logger.
         */
        public function InternalLogger( channel:String )
        {
            _channel = channel;
        }
        
        /**
         * Indicates the channel value for the logger.
         */
        public function get channel():String
        {
            return _channel ;
        }
        
        /**
         * Logs the specified data using the LogEventLevel.DEBUG level.
         * @param context The information to log. This string can contain special marker characters of the form {x}, where x is a zero based index that will be replaced with the additional parameters found at that index if specified.
         * @param ... Additional parameters that can be subsituted in the str parameter at each "{x}" location, where x is an integer (zero based) index value into the Array of values specified.
         */
        public function debug( context:* , ...rest ):void
        {
            _log.apply( this, [ LoggerLevel.DEBUG , context].concat(rest) ) ;
        }
        
        /**
         * Logs the specified data using the LogEventLevel.ERROR level.
         * @param context The information to log. This string can contain special marker characters of the form {x}, where x is a zero based index that will be replaced with the additional parameters found at that index if specified.
         * @param ... Additional parameters that can be subsituted in the str parameter at each "{x}" location, where x is an integer (zero based) index value into the Array of values specified.
         */
        public function error( context:* , ...rest ):void
        {
            _log.apply( this, [ LoggerLevel.ERROR, context ].concat(rest) ) ;
        }
        
        /**
         * Logs the specified data using the LogEventLevel.FATAL level.
         * @param context The information to log. This string can contain special marker characters of the form {x}, where x is a zero based index that will be replaced with the additional parameters found at that index if specified.
         * @param ... Additional parameters that can be subsituted in the str parameter at each "{x}" location, where x is an integer (zero based) index value into the Array of values specified.     
         */
        public function fatal(context:*, ...rest):void
        {
            _log.apply( this, [ LoggerLevel.FATAL, context ].concat(rest) ) ;
        }
        
        /**
         * Logs the specified data using the LogEvent.INFO level.
         * @param context The information to log. This string can contain special marker characters of the form {x}, where x is a zero based index that will be replaced with the additional parameters found at that index if specified.
         * @param ... Additional parameters that can be subsituted in the str parameter at each "{x}" location, where x is an integer (zero based) index value into the Array of values specified.
         */
        public function info(context:*, ...rest):void
        {
            _log.apply( this, [ LoggerLevel.INFO , context].concat(rest) ) ;
        }
        
        /**
         * Logs the specified data at the given level.
         * @param level The level this information should be logged at. Valid values are:<p>
         * <li>LogEventLevel.FATAL designates events that are very harmful and will eventually lead to application failure</li>
         * <li>LogEventLevel.ERROR designates error events that might still allow the application to continue running.</li>
         * <li>LogEventLevel.WARN designates events that could be harmful to the application operation</li>
         * <li>LogEventLevel.INFO designates informational messages that highlight the progress of the application at coarse-grained level.</li>
         * <li>LogEventLevel.DEBUG designates informational level messages that are fine grained and most helpful when debugging an application.</li>
         * <li>LogEventLevel.ALL intended to force a target to process all messages.</li></p>
         * @param context The information to log. This string can contain special marker characters of the form {x}, where x is a zero based index that will be replaced with the additional parameters found at that index if specified.
         * @param ... Additional parameters that can be subsituted in the str parameter at each "{x}" location, where x is an integer (zero based) index value into the Array of values specified.
         */
        public function log( level:LoggerLevel, context:*, ...rest ):void
        {
            if ( level < LoggerLevel.DEBUG )
            {
                throw new ArgumentError("Level must be less than LogEventLevel.ALL.");
            }
           _log.apply( this, [level, context].concat(rest) ) ;
        }
        
        /**
         * Logs the specified data using the LogEventLevel.WARN level.
         * @param context The information to log. This string can contain special marker characters of the form {x}, where x is a zero based index that will be replaced with the additional parameters found at that index if specified.
         * @param ... Additional parameters that can be subsituted in the str parameter at each "{x}" location, where x is an integer (zero based) index value into the Array of values specified.
         */
        public function warn(context:*, ...rest):void
        {
            _log.apply( this, [ LoggerLevel.WARN , context ].concat(rest) ) ;
        }
        
        /**
         * @private
         */
        private var _channel:String ;
        
        /**
         * @private
         */
        private function _log( level:LoggerLevel, context:*, ...rest ):void
        {
            if( hasEventListener( LoggerEvent.LOG ) )
            {
                if ( context is String )
                {
                    var len:int = rest.length ;
                    for( var i:int ; i<len ; i++ )
                    {
                        context = (context as String).replace(new RegExp("\\{"+i+"\\}", "g"), rest[i]);
                    }
                }
                dispatchEvent( new LoggerEvent( context, level ) ) ;
            }
        }
    }
}