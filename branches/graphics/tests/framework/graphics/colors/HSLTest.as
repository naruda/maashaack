﻿/*  Version: MPL 1.1/GPL 2.0/LGPL 2.1   The contents of this file are subject to the Mozilla Public License Version  1.1 (the "License"); you may not use this file except in compliance with  the License. You may obtain a copy of the License at  http://www.mozilla.org/MPL/    Software distributed under the License is distributed on an "AS IS" basis,  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License  for the specific language governing rights and limitations under the  License.    The Original Code is [maashaack framework].    The Initial Developers of the Original Code are  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.  Portions created by the Initial Developers are Copyright (C) 2006-2009  the Initial Developers. All Rights Reserved.    Contributor(s):    Alternatively, the contents of this file may be used under the terms of  either the GNU General Public License Version 2 or later (the "GPL"), or  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),  in which case the provisions of the GPL or the LGPL are applicable instead  of those above. If you wish to allow use of your version of this file only  under the terms of either the GPL or the LGPL, and not to allow others to  use your version of this file under the terms of the MPL, indicate your  decision by deleting the provisions above and replace them with the notice  and other provisions required by the LGPL or the GPL. If you do not delete  the provisions above, a recipient may use your version of this file under  the terms of any one of the MPL, the GPL or the LGPL.*/package graphics.colors {    import buRRRn.ASTUce.framework.TestCase;    public class HSLTest extends TestCase     {        public function HSLTest(name:String = "")        {            super(name);        }                public function testConstructor():void        {            var hsl:HSL ;                        hsl = new HSL() ;            assertNotNull( hsl     , "01-01 - Constructor failed." ) ;            assertEquals(hsl.h , 0 , "01-02 - Constructor failed with the h parameter.") ;            assertEquals(hsl.s , 0 , "01-03 - Constructor failed with the s parameter.") ;            assertEquals(hsl.l , 0 , "01-04 - Constructor failed with the l parameter.") ;                        hsl = new HSL(180,1,0.5) ;            assertNotNull( hsl       , "02-01 - Constructor failed." ) ;            assertEquals(hsl.h , 180 , "02-02 - Constructor failed with the h parameter.") ;            assertEquals(hsl.s , 1   , "02-03 - Constructor failed with the s parameter.") ;            assertEquals(hsl.l , 0.5 , "02-04 - Constructor failed with the l parameter.") ;        }                public function testInterface():void        {            var hsl:HSL = new HSL() ;            assertTrue( hsl is ColorSpace , "HSL must implements the ColorSpace interface.") ;        }                public function testH():void        {            var hsl:HSL = new HSL() ;                        assertEquals(hsl.h , 0 , "01 - h property failed.") ;                        hsl.h = 180 ;            assertEquals(hsl.h , 180 , "02 - h property failed.") ;                        hsl.h = 255.5 ;            assertEquals(hsl.h , 255.5 , "03 - h property failed.") ;                        hsl.h = 360 ;            assertEquals(hsl.h , 0 , "04 - h property failed.") ;                        hsl.h = -10 ;            assertEquals(hsl.h , 350 , "05 - h property failed.") ;                        hsl.h = 370 ;            assertEquals(hsl.h , 10 , "06 - h property failed.") ;                        hsl.h = NaN ;            assertEquals(hsl.h , 0 , "07 - h property failed with the NaN value.") ;        }                public function testS():void        {            var hsl:HSL = new HSL() ;                        assertEquals(hsl.s , 0 , "01 - s property failed.") ;                        hsl.s = 1 ;            assertEquals(hsl.s , 1 , "02 - s property failed.") ;                        hsl.s = 0.5 ;            assertEquals(hsl.s , 0.5 , "03 - s property failed.") ;                        hsl.s = NaN ;            assertEquals(hsl.s , 0 , "04 - s property failed with the NaN value.") ;                        hsl.s = -10 ;            assertEquals(hsl.s , 0 , "05 - s property failed with negative value.") ;                        hsl.s = 10 ;            assertEquals(hsl.s , 1 , "06 - s property failed with >1 value.") ;        }                public function testV():void        {            var hsl:HSL = new HSL() ;                        assertEquals(hsl.l , 0 , "01 - l property failed.") ;                        hsl.l = 1 ;            assertEquals(hsl.l , 1 , "02 - l property failed.") ;                        hsl.l = 0.5 ;            assertEquals(hsl.l , 0.5 , "03 - l property failed.") ;                        hsl.l = NaN ;            assertEquals(hsl.l , 0 , "04 - l property failed with the NaN value.") ;                        hsl.l = -10 ;            assertEquals(hsl.l , 0 , "05 - l property failed with negative value.") ;                        hsl.l = 10 ;            assertEquals(hsl.l , 1 , "06 - l property failed with >1 value.") ;        }                public function testClone():void        {            var hsl:HSL = new HSL(180,1,0.5) ;            var clone:HSL = hsl.clone() as HSL ;                         assertNotNull( clone , "01 - clone method failed." ) ;                        assertEquals(hsl.h , clone.h , "02-01 clone method failed.") ;            assertEquals(hsl.s , clone.s , "02-02 clone method failed.") ;            assertEquals(hsl.l , clone.l , "02-03 clone method failed.") ;                        assertEquals(hsl , clone , "03 clone method failed, use the equals method.") ;        }                public function testEquals():void        {            var hsl1:HSL = new HSL(180,1,0.5) ;            var hsl2:HSL = new HSL(180,1,0.5) ;            var hsl3:HSL = new HSL(190,1,0.5) ;            var hsl4:HSL = new HSL(180,0.4,0.5) ;            var hsl5:HSL = new HSL(180,1,0.6) ;                        assertTrue( hsl1.equals(hsl1) , "01 equals method failed.") ;            assertTrue( hsl1.equals(hsl2) , "02 equals method failed.") ;                        assertFalse( hsl1.equals(hsl3) , "03 equals method failed.") ;            assertFalse( hsl1.equals(hsl4) , "04 equals method failed.") ;            assertFalse( hsl1.equals(hsl5) , "05 equals method failed.") ;        }                public function testSet():void        {            var hsl:HSL = new HSL() ;            hsl.set(180,1,0.5) ;                        assertEquals(hsl.h , 180 , "01 - set method failed.") ;            assertEquals(hsl.s , 1   , "02 - set method failed.") ;            assertEquals(hsl.l , 0.5 , "03 - set method failed.") ;        }                public function testToObject():void        {            var hsl:HSL = new HSL(180,1,0.5) ;            var object:Object = hsl.toObject() as Object;                         assertNotNull( object , "01 - toObject method failed." ) ;                        assertEquals(hsl.h , object.h , "02-01 toObject method failed.") ;            assertEquals(hsl.s , object.s , "02-02 toObject method failed.") ;            assertEquals(hsl.l , object.l , "02-03 toObject method failed.") ;                        assertFalse( hsl.equals(object) , "03 toObject method failed.") ;        }                public function testToSource():void        {            var hsl:HSL = new HSL(180,1,0.5) ;            assertEquals(hsl.toSource() , "new graphics.colors.HSL(180,1,0.5)" , "toSource method failed.") ;        }                public function testToString():void        {            var hsl:HSL = new HSL(180,1,0.5) ;            assertEquals(hsl.toString() , "[HSL h:180 s:1 l:0.5]" , "toString method failed.") ;        }    }}