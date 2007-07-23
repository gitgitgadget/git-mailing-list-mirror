From: Nicolas Pitre <nico@cam.org>
Subject: Re: Git tree for old kernels from before the current tree
Date: Mon, 23 Jul 2007 13:48:06 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707231343350.6355@xanadu.home>
References: <9e4733910707221349s462aa11bj714956f7cdc72aac@mail.gmail.com>
 <Pine.LNX.4.64.0707222257540.32367@fbirervta.pbzchgretzou.qr>
 <20070722211314.GA13850@linux-sh.org>
 <Pine.LNX.4.64.0707222344540.32367@fbirervta.pbzchgretzou.qr>
 <Pine.LNX.4.64.0707230000170.32367@fbirervta.pbzchgretzou.qr>
 <46A3D5EA.2050600@zytor.com>
 <alpine.LFD.0.999.0707230950340.3607@woody.linux-foundation.org>
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
X-From: git-owner@vger.kernel.org Mon Jul 23 19:48:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID211-0007HY-7g
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 19:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761030AbXGWRsL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 13:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760793AbXGWRsL
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 13:48:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30068 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760739AbXGWRsK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 13:48:10 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JLN004OO846KUM0@VL-MH-MR002.ip.videotron.ca>; Mon,
 23 Jul 2007 13:48:07 -0400 (EDT)
In-reply-to: <alpine.LFD.0.999.0707230950340.3607@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53453>

On Mon, 23 Jul 2007, Linus Torvalds wrote:

> So I've been thinking about trying to re-create some really old history 
> into git, but it's still a lot of work.. And obviously not very useful, 
> just interesting from an archeological standpoint.

I started this once.

I have (sort of) a GIT tree with all Linux revisions that I could find 
from v0.01 up to v1.0.9.  But the most interesting information and also 
what is the most time consuming is the retrieval of announcement 
messages for those releases in old mailing list or newsgroup archives to 
serve as commit log data.  It seems to be even arder to find for post 
v1.0 releases.


Nicolas
