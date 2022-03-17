OpenSSL interface library for gcc-Ada (GNAT)
============================================

What's this?
------------

Ada binding to a part of OpenSSL.

Prerequisites
-------------

GCC >= 5
 https://gcc.gnu.org/
OpenSSL >= 1.0.2
 http://www.openssl.org/
headmaster
  http://github.com/ytomino/headmaster

Usage
-----

1. Prepare the translated headers.

   A. Translate the C headers with headmaster. ::

       $ headmaster --to ada -p -D import-dir openssl-ada/source/import.h
      
      However, it may not work well in your environment.
      The plan B is recommended.

   B. Download them from `pre-translated headers page`_.

2. Add the source directories of openssl-ada and the translated headers
   to search path for gnatmake. ::

    $ gnatmake -Iopenssl-ada/source -Iimport-dir your_main.adb
   
   Or please write .gpr file for your environment.

Build examples
--------------

1. Link the translated headers to `examples/import`. ::

    $ mkdir openssl-ada/examples/import
    $ ln -s $PWD/import-dir openssl-ada/examples/import/$(gcc -dumpmachine)
   
   If this step is omitted, headmaster will be used.

2. Build them. ::

    $ make -C openssl-ada/examples

License
-------

It is licensed under the New BSD License, see below.
Also, please apply the license of OpenSSL when static linking.

**license of openssl-ada** ::

 Copyright 2010-2021 YT. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:
 1. Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.
 2. Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE AUTHOR(S) ``AS IS'' AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 IN NO EVENT SHALL THE AUTHOR(S) BE LIABLE FOR ANY DIRECT, INDIRECT,
 INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

**license of OpenSSL** ::

 /* ====================================================================
  * Copyright (c) 1998-2008 The OpenSSL Project.  All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions
  * are met:
  *
  * 1. Redistributions of source code must retain the above copyright
  *    notice, this list of conditions and the following disclaimer.
  *
  * 2. Redistributions in binary form must reproduce the above copyright
  *    notice, this list of conditions and the following disclaimer in
  *    the documentation and/or other materials provided with the
  *    distribution.
  *
  * 3. All advertising materials mentioning features or use of this
  *    software must display the following acknowledgment:
  *    "This product includes software developed by the OpenSSL Project
  *    for use in the OpenSSL Toolkit. (http://www.openssl.org/)"
  *
  * 4. The names "OpenSSL Toolkit" and "OpenSSL Project" must not be used to
  *    endorse or promote products derived from this software without
  *    prior written permission. For written permission, please contact
  *    openssl-core@openssl.org.
  *
  * 5. Products derived from this software may not be called "OpenSSL"
  *    nor may "OpenSSL" appear in their names without prior written
  *    permission of the OpenSSL Project.
  *
  * 6. Redistributions of any form whatsoever must retain the following
  *    acknowledgment:
  *    "This product includes software developed by the OpenSSL Project
  *    for use in the OpenSSL Toolkit (http://www.openssl.org/)"
  *
  * THIS SOFTWARE IS PROVIDED BY THE OpenSSL PROJECT ``AS IS'' AND ANY
  * EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
  * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE OpenSSL PROJECT OR
  * ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
  * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
  * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
  * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
  * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
  * OF THE POSSIBILITY OF SUCH DAMAGE.
  * ====================================================================
  *
  * This product includes cryptographic software written by Eric Young
  * (eay@cryptsoft.com).  This product includes software written by Tim
  * Hudson (tjh@cryptsoft.com).
  *
  */

.. _`pre-translated headers page`: https://github.com/ytomino/openssl-ada/wiki/Pre-translated-headers
