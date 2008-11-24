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
  Portions created by the Initial Developers are Copyright (C) 2006-2008
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

package system.data.iterators 
{
    import system.data.ListIterator;
    import system.data.errors.ConcurrentModificationError;
    import system.data.errors.NoSuchElementError;
    import system.data.lists.ArrayList;
    import system.numeric.Mathematics;
    
    import flash.errors.IllegalOperationError;    

    [ExcludeClass]

    /**
     * The basic implementation of the <code class="prettyprint">ListIterator</code> used in the <code class="prettyprint">ArrayList</code> class.
     * <p>This class is public but you not must use it directly.</p>
     */
    public class ArrayListIterator implements ListIterator 
    {
        
        /**
         * Creates a new ArrayListIterator instance.
         */
        public function ArrayListIterator( li:ArrayList )
        {
            if ( li == null ) 
            {
                throw new ArgumentError( "ListIterator.constructor, the 'list' argument in the constructor not must be 'null' or 'undefined'.") ;
            }
            _list             = li ;
            _key              = 0 ;
            _listast          = -1 ;
            _expectedModCount = (_list as ArrayList).getModCount() ;        	
        }
        
        /**
         * Inserts an object in the list during the iteration process.
         */
        public function add( o:* ):void 
        {
            checkForComodification() ;
            try 
            {
                _list.addAt( _key++ , o ) ;
                _listast = -1 ;
                _expectedModCount = _list.getModCount() ;
            } 
            catch ( e:Error ) 
            {
                throw e ;
            }   
        }        
        
        /**
         * Invoked to check for comodification.
         */
        public function checkForComodification():void 
        {
            var l:ArrayList = _list as ArrayList ;
            if (l != null && l.getModCount() != _expectedModCount) 
            {
                throw new ConcurrentModificationError( "ListIterator modification impossible.") ;
            }
        }
    
        /**
         * Returns <code class="prettyprint">true</code> if the iteration has more elements.
         * @return <code class="prettyprint">true</code> if the iteration has more elements.
         */ 
        public function hasNext():Boolean 
        {
            return _key < _list.size() ;
        }

        /**
         * Checks to see if there is a previous element that can be iterated to.
         */
        public function hasPrevious():Boolean 
        { 
            return _key != 0 ;
        }
                
        /**
         * Returns the current key of the internal pointer of the iterator (optional operation).
         * @return the current key of the internal pointer of the iterator (optional operation).
         */
        public function key():*
        {
            return _key ;
        }

        /**
         * Returns the next element in the iteration.
         * @return the next element in the iteration.
         */
        public function next():* 
        {
            if ( hasNext() ) 
            {
                var next:* = _list.get( _key ) ;
                _listast   = _key ;
                _key++ ;
                return next ;
            }
            else 
            {   
                throw new NoSuchElementError( "ListIterator.next() method failed." ) ;
            }
        }
        
        /**
         * Returns the next index value of the iterator.
         * @return the next index value of the iterator.
         */
        public function nextIndex():uint 
        {
            return _key ;
        }
        
        /**
         * Returns the previous element in the collection.
         * @return the previous element in the collection.
         */
        public function previous():*
        {
            checkForComodification() ;
            try 
            {
                var i:Number = _key - 1 ;
                var prev:*   = _list.get(i) ;
                _listast     = _key  = i ;
                return prev ;
            }
            catch( e:Error ) 
            {
                checkForComodification() ;
                throw new NoSuchElementError( "ListIterator.previous method failed.") ;
            }
        }

        /**
         * Returns the previous index value of the iterator.
         * @return the previous index value of the iterator.
         */
        public function previousIndex():int 
        {
            return _key - 1 ;
        }
        
        /**
         * Removes from the underlying collection the last element returned by the iterator (optional operation).
         */
        public function remove():*
        {
            if (_listast == -1) 
            {
            	throw new IllegalOperationError( "ListIterator.remove() failed, the iterator state is not valid.") ;
            }
            checkForComodification() ;
            try 
            {
                _list.removeAt(_listast) ;
                if (_listast < _key) 
                {
                	_key -- ;
                }
                _listast = -1 ;
                _expectedModCount = _list.getModCount() ;
            } 
            catch ( e:ConcurrentModificationError ) 
            {
                throw new ConcurrentModificationError( "ListIterator.remove() method failed.") ;
            }
        }   

        /**
         * Reset the internal pointer of the iterator (optional operation).
         */
        public function reset():void 
        {
            _key = 0 ;
        }
            
        /**
        * Change the position of the internal pointer of the iterator (optional operation).
        */
        public function seek(position:*):void 
        {
            _key = Mathematics.clamp(position, 0, _list.size()) ;
            _listast = _key - 1 ;
        }
            
        /**
         * Sets the last element returned by the iterator.
         */
        public function set( o:* ):void
        {
            if (_listast == -1) 
            {
                throw new IllegalOperationError( "ListIterator.set() failed, the iterator state is not valid.") ;
            }
            checkForComodification() ;
            try 
            {
                _list.setAt( _listast , o ) ;
                _expectedModCount = _list.getModCount() ;
            }
            catch ( e:ConcurrentModificationError ) 
            {
                throw e ;
            }
        }        
        
        /**
         * @private
         */
        private var _expectedModCount:Number ;  
    
        /**
         * @private
         */
        private var _key:uint ;
        
        /**
         * @private
         */
        private var _list:ArrayList ;
    
        /**
         * @private
         */
        private var _listast:int ;        
        
    }
}
