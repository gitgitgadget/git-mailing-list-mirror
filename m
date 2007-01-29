From: Nicolas Pitre <nico@cam.org>
Subject: Re: More precise tag following
Date: Mon, 29 Jan 2007 12:58:39 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701291246090.3021@xanadu.home>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>
 <20070127080126.GC9966@spearce.org>
 <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
 <45BB9C8B.8020907@fs.ei.tum.de>
 <Pine.LNX.4.64.0701271103520.25027@woody.linux-foundation.org>
 <204011cb0701271136m655815f6o1501de2bf699b362@mail.gmail.com>
 <Pine.LNX.4.63.0701281425270.26863@qynat.qvtvafvgr.pbz>
 <Pine.LNX.4.64.0701291224100.3021@xanadu.home>
 <Pine.LNX.4.64.0701290940520.3611@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: David Lang <david.lang@digitalinsight.com>,
	Chris Lee <clee@kde.org>,
	Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 29 18:58:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBamD-0006tL-Bv
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 18:58:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbXA2R6l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 12:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752537AbXA2R6l
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 12:58:41 -0500
Received: from relais.videotron.ca ([24.201.245.36]:23591 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536AbXA2R6k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 12:58:40 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCN002PC5XR3FB0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 29 Jan 2007 12:58:40 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0701290940520.3611@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38087>

On Mon, 29 Jan 2007, Linus Torvalds wrote:

> 
> 
> On Mon, 29 Jan 2007, Nicolas Pitre wrote:
> > 
> > Chris: why don't you just set up a Bittorrent feed for it?  When we'll 
> > all start fetching it then the bandwidth will increasingly be shared 
> > amongst all interested people.
> 
> Well, it doesn't really help Chris. All the data will end up starting from 
> him anyway. 

Sure, but I was under the impression this wasn't the problem.  Given 
what Chris said:

|I don't have access to any servers that I could drop a 3GB packfile 
|onto and expect them to serve it. [...] If anybody wants to hook me up
|with a hosting provider or a machine that just the git devs can access, 
|I'd be willing to tie up my upstream bandwidth for a few days so you 
|all can have access to it.

And then David said:

|if nobody else steps forward I can arrange something like this on my 
|home server (only 768K updtream bandwidth, but it's better then 
|nothing)

So it looks like the server was the main issue here.

> Once it's uploaded anywhere, we've got people willing to mirror it 
> infinitely ..

Has this been set up with Chris already?


Nicolas
