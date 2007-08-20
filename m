From: Nicolas Pitre <nico@cam.org>
Subject: Re: Git tree for old kernels from before the current tree
Date: Mon, 20 Aug 2007 16:46:49 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0708201643450.16727@xanadu.home>
References: <20070722211314.GA13850@linux-sh.org>
 <Pine.LNX.4.64.0707222344540.32367@fbirervta.pbzchgretzou.qr>
 <Pine.LNX.4.64.0707230000170.32367@fbirervta.pbzchgretzou.qr>
 <46A3D5EA.2050600@zytor.com>
 <alpine.LFD.0.999.0707230950340.3607@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707231343350.6355@xanadu.home>
 <alpine.LFD.0.999.0707231057480.3607@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707231432560.6355@xanadu.home>
 <20070723234628.GN21668@ftp.linux.org.uk>
 <alpine.LFD.0.999.0707231957450.6355@xanadu.home>
 <20070820200914.GB11718@lug-owl.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Al Viro <viro@ftp.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jan Engelhardt <jengelh@computergmbh.de>,
	Paul Mundt <lethal@linux-sh.org>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
X-From: git-owner@vger.kernel.org Mon Aug 20 22:47:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INE9L-0004dr-B1
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 22:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754361AbXHTUqx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 16:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752441AbXHTUqw
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 16:46:52 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46347 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbXHTUqv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 16:46:51 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JN3004ICB21KB20@VL-MO-MR002.ip.videotron.ca>; Mon,
 20 Aug 2007 16:46:50 -0400 (EDT)
In-reply-to: <20070820200914.GB11718@lug-owl.de>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56258>

On Mon, 20 Aug 2007, Jan-Benedict Glaw wrote:

> On Mon, 2007-07-23 20:10:23 -0400, Nicolas Pitre <nico@cam.org> wrote:
> > 
> > I have sanitized .tgz files that I use to stuff a Git repo with.  I 
> > recall that some of them were reconstructed through patching an earlier 
> > or later kernel version because the original ones were corrupted. Some 
> > patches were retrieved from other archival sites, etc.  Then the result 
> > was 
> > cross checked with summary lists like this one: 
> > 
> > http://www.uwsg.iu.edu/hypermail/linux/kernel/0110.1/1684.html
> > 
> > This was a while ago so I don't remember the exact steps, but that 
> > wasn't always trivial.
> 
> Some years ago, I also worked on old Linux releases. Have you found
> the tarballs in my directory at kernel.org?

No, I didn't know about them.

>From a quick look, I think I already captured everything you have prior 
v1.0 though.


Nicolas
