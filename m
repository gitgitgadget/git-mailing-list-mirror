From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 21:45:01 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003182141050.31128@xanadu.home>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
 <alpine.LFD.2.00.1003181909180.31128@xanadu.home>
 <9e4733911003181626t7d143903mbc5737ff2fa5100f@mail.gmail.com>
 <alpine.LFD.2.00.1003181930230.31128@xanadu.home>
 <9e4733911003181641n400704c9r1a0addd6fce6fce0@mail.gmail.com>
 <alpine.LFD.2.00.1003181953010.31128@xanadu.home>
 <9e4733911003181716q7f141d5eqd18218c749ca4624@mail.gmail.com>
 <alpine.LFD.2.00.1003181715490.18017@i5.linux-foundation.org>
 <9e4733911003181739m2f605dd7g9406aaecc296749f@mail.gmail.com>
 <alpine.LFD.2.00.1003181739310.18017@i5.linux-foundation.org>
 <9e4733911003181812k1cf08833ke683226377527b56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 02:54:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsRQK-0003Xp-24
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 02:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701Ab0CSByq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 21:54:46 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39791 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978Ab0CSByq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 21:54:46 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KZI00B5DA71N3F0@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 18 Mar 2010 21:45:01 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733911003181812k1cf08833ke683226377527b56@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142553>

On Thu, 18 Mar 2010, Jon Smirl wrote:

> On Thu, Mar 18, 2010 at 8:50 PM, Linus Torvalds
> > There is no real _value_ in making a .mailcap for each such buggy entry is
> > what I'm trying to tell you. Those things are maybe used for statistics.
> > On the whole, they are correct.
> 
> I was trying to track how many real people were working on the kernel.
>  If we don't collapse the 13 different versions of you down to one
> person the number numbers are way off.

If you have a cleaned up .mailmap file which doesn't include unneeded 
entries then just submit it for inclusion.  If someone else eventually 
cares to check and update it then another patch should come forth at 
that point.  That doesn't have to be any more complicated than that.


Nicolas
