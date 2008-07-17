From: "Craig L. Ching" <cching@mqsoftware.com>
Subject: Subversion's do-everything-via-copying paradigm ( was RE:  Re: Considering teaching plumbing to users harmful)
Date: Thu, 17 Jul 2008 11:18:06 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F79430238A16B@emailmn.mqsoftware.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer><32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com><alpine.DEB.1.00.0807161902400.8986@racer><32541b130807161135h64024151xc60e23d222a3a508@mail.gmail.com><alpine.LNX.1.00.0807161605550.19665@iabervon.org><861w1sn4id.fsf@lola.quinscape.zz><m3od4wse30.fsf@localhost.localdomain> A<86k5fk1ooq.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "David Kastrup" <dak@gnu.org>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 17 18:20:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJWCu-0008Hk-7A
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 18:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754972AbYGQQSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 12:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753689AbYGQQSx
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 12:18:53 -0400
Received: from emailmn.mqsoftware.com ([66.192.70.108]:4178 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861AbYGQQSx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jul 2008 12:18:53 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: A<86k5fk1ooq.fsf@lola.quinscape.zz>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Subversion's do-everything-via-copying paradigm ( was RE:  Re: Considering teaching plumbing to users harmful)
Thread-Index: AcjoJ1giWa7Y/arUQ2SQ/6j3eX0RxwAAQTaA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88873>

 

> -----Original Message-----
> From: git-owner@vger.kernel.org 
> [mailto:git-owner@vger.kernel.org] On Behalf Of David Kastrup
> Sent: Thursday, July 17, 2008 11:05 AM
> To: git@vger.kernel.org
> Subject: Re: Considering teaching plumbing to users harmful
> 
> How much have you worked with Subversion so far?  I am doing 
> quite a bit of work with it, and the 
> do-everything-via-copying paradigm does not get in my hair.  
> It actually means that I have to remember fewer commands.
> And it is pretty easy to understand.
> 

Does it not bother you that renaming a file is a copy + delete [1].
Have they fixed that yet?  That was one of the biggest reasons we never
moved to subversion.

Ok, I'm done picking on Subversion for now :-P

[1] -- http://subversion.tigris.org/issues/show_bug.cgi?id=898

> --
> David Kastrup
> 

Cheers,
Craig
