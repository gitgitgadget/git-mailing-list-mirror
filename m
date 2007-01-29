From: Nicolas Pitre <nico@cam.org>
Subject: Re: More precise tag following
Date: Mon, 29 Jan 2007 12:34:20 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701291224100.3021@xanadu.home>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>
 <20070127080126.GC9966@spearce.org>
 <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
 <45BB9C8B.8020907@fs.ei.tum.de>
 <Pine.LNX.4.64.0701271103520.25027@woody.linux-foundation.org>
 <204011cb0701271136m655815f6o1501de2bf699b362@mail.gmail.com>
 <Pine.LNX.4.63.0701281425270.26863@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Chris Lee <clee@kde.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: David Lang <david.lang@digitalinsight.com>
X-From: git-owner@vger.kernel.org Mon Jan 29 18:34:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBaOi-000401-4r
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 18:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbXA2ReW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 12:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752036AbXA2ReW
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 12:34:22 -0500
Received: from relais.videotron.ca ([24.201.245.36]:46699 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031AbXA2ReV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 12:34:21 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCN005QX4T8STC0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 29 Jan 2007 12:34:20 -0500 (EST)
In-reply-to: <Pine.LNX.4.63.0701281425270.26863@qynat.qvtvafvgr.pbz>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38084>

On Sun, 28 Jan 2007, David Lang wrote:

> On Sat, 27 Jan 2007, Chris Lee wrote:
> 
> > From: Chris Lee <clee@kde.org>
> > On 1/27/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > > Do you have the converted repo somewhere to be cloned for? It's going to
> > > be a lot more interesting for scalability testing than anything else.
> >
> > I don't have access to any servers that I could drop a 3GB packfile
> > onto and expect them to serve it. And I don't have a connection at
> > home that I could use to upload the 3GB pack from quickly - it would
> > take days, at least. If anybody wants to hook me up with a hosting
> > provider or a machine that just the git devs can access, I'd be
> > willing to tie up my upstream bandwidth for a few days so you all can
> > have access to it.

> if nobody else steps forward I can arrange something like this on my home
> server (only 768K updtream bandwidth, but it's better then nothing)

Hey guys,

We might be a couple people interested in this pack (I do as pack 
performance is one of my main interest in git).  Linus is interested, 
and I'd guess Junio too, maybe a few others.

Chris: why don't you just set up a Bittorrent feed for it?  When we'll 
all start fetching it then the bandwidth will increasingly be shared 
amongst all interested people.


Nicolas
