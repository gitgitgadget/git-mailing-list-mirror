From: Nicolas Pitre <nico@cam.org>
Subject: Re: Git tree for old kernels from before the current tree
Date: Mon, 23 Jul 2007 15:08:59 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707231507040.6355@xanadu.home>
References: <9e4733910707221349s462aa11bj714956f7cdc72aac@mail.gmail.com>
 <Pine.LNX.4.64.0707222257540.32367@fbirervta.pbzchgretzou.qr>
 <20070722211314.GA13850@linux-sh.org>
 <Pine.LNX.4.64.0707222344540.32367@fbirervta.pbzchgretzou.qr>
 <Pine.LNX.4.64.0707230000170.32367@fbirervta.pbzchgretzou.qr>
 <46A3D5EA.2050600@zytor.com>
 <alpine.LFD.0.999.0707230950340.3607@woody.linux-foundation.org>
 <20070723185732.GB30165@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jan Engelhardt <jengelh@computergmbh.de>,
	Paul Mundt <lethal@linux-sh.org>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 23 21:09:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID3HG-0002no-Ln
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 21:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763044AbXGWTJB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 15:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762842AbXGWTJB
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 15:09:01 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36559 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762638AbXGWTJA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 15:09:00 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JLN004EGBUZKUY0@VL-MH-MR002.ip.videotron.ca>; Mon,
 23 Jul 2007 15:08:59 -0400 (EDT)
In-reply-to: <20070723185732.GB30165@thunk.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53463>

On Mon, 23 Jul 2007, Theodore Tso wrote:

> On Mon, Jul 23, 2007 at 09:55:24AM -0700, Linus Torvalds wrote:
> > 
> > I actually tried to get something like this together back in the BK days 
> > and early in the SCO saga. It was pretty painful to try to find all the 
> > historic trees and patches - they're all in different format, and some of 
> > them are unreliable (ie CVS imports by people like Ted).
> 
> Um, *I* never had the bad taste to import Linux kernels into CVS.  :-)
> 
> I'm pretty sure we never had anything like that on tsx-11.mit.edu, either.

Well, I remember having to clean up some of the source archives I've 
found which contained CVS directories.  Can't tell which one anymore, 
but they were amongst the oldest ones.


Nicolas
