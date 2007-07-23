From: Nicolas Pitre <nico@cam.org>
Subject: Re: Git tree for old kernels from before the current tree
Date: Mon, 23 Jul 2007 16:45:10 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707231638330.6355@xanadu.home>
References: <9e4733910707221349s462aa11bj714956f7cdc72aac@mail.gmail.com>
 <Pine.LNX.4.64.0707222257540.32367@fbirervta.pbzchgretzou.qr>
 <20070722211314.GA13850@linux-sh.org>
 <Pine.LNX.4.64.0707222344540.32367@fbirervta.pbzchgretzou.qr>
 <Pine.LNX.4.64.0707230000170.32367@fbirervta.pbzchgretzou.qr>
 <46A3D5EA.2050600@zytor.com>
 <alpine.LFD.0.999.0707230950340.3607@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707231343350.6355@xanadu.home>
 <alpine.LFD.0.999.0707231057480.3607@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707231432560.6355@xanadu.home>
 <alpine.LFD.0.999.0707231250390.3607@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Jan Engelhardt <jengelh@computergmbh.de>,
	Paul Mundt <lethal@linux-sh.org>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 22:45:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID4mn-0000Z3-6I
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 22:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934914AbXGWUpT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 16:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933068AbXGWUpR
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 16:45:17 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28652 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934880AbXGWUpN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 16:45:13 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JLN0042HGBBVK90@VL-MH-MR001.ip.videotron.ca>; Mon,
 23 Jul 2007 16:45:11 -0400 (EDT)
In-reply-to: <alpine.LFD.0.999.0707231250390.3607@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53481>

On Mon, 23 Jul 2007, Linus Torvalds wrote:

> 
> 
> On Mon, 23 Jul 2007, Nicolas Pitre wrote:
> > 
> > What is missing is:
> > 
> >  - v0.02 sources
> 
> I think this really is gone. 0.03 was such an improvement on 0.02 that I 
> think what happened was that I literally removed 0.02 (hey, it wasn't 
> historically interesting at the time!). It's not the first time people 
> have wondered about it.
> 
> 0.03 was the first version where you could actually do things under Linux, 
> and I think I could compile etc. I *think* it was released pretty close 
> after 0.02, which made 0.02 appear even more flawed and a brown-paper-bag 
> release.

Could that version be found anywhere?

> >  - v0.10 announcement
> 
> Hmm. That one would be interesting, since the reason for the 0.03->0.10 
> jump was that I was getting so happy with how it was actually working for 
> me (ie able to compile itself under itself). But I don't see it, and it's 
> not on google in the comp.os.minix archives either, afaik.

Anyone out there keeping an archive of those old posts?  Archival sites 
appear to have a black hole during that period.

> >  - v0.99.12 announcement
> 
> Well, the 0.99.12 announcement is found by google.
> 
> 	http://groups.google.com/group/comp.os.linux.announce/browse_thread/thread/8a19289f68a4af35/fe433c9df4b382a5?lnk=st&q=&rnum=1#fe433c9df4b382a5
> 
> In general, google groups (search by date and author, and make the group 
> be something like *linux*) is good, I found the above on the first try.

Yeah... Don't know what happened.  I must have found it then because I 
had a file to store it in my data directory, but somehow it was empty.  
Fixed now.


Nicolas
