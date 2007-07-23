From: Theodore Tso <tytso@mit.edu>
Subject: Re: Git tree for old kernels from before the current tree
Date: Mon, 23 Jul 2007 16:22:10 -0400
Message-ID: <20070723202210.GC30165@thunk.org>
References: <9e4733910707221349s462aa11bj714956f7cdc72aac@mail.gmail.com> <Pine.LNX.4.64.0707222257540.32367@fbirervta.pbzchgretzou.qr> <20070722211314.GA13850@linux-sh.org> <Pine.LNX.4.64.0707222344540.32367@fbirervta.pbzchgretzou.qr> <Pine.LNX.4.64.0707230000170.32367@fbirervta.pbzchgretzou.qr> <46A3D5EA.2050600@zytor.com> <alpine.LFD.0.999.0707230950340.3607@woody.linux-foundation.org> <20070723185732.GB30165@thunk.org> <alpine.LFD.0.999.0707231242090.3607@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Jan Engelhardt <jengelh@computergmbh.de>,
	Paul Mundt <lethal@linux-sh.org>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 22:23:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID4RL-0001bw-Q6
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 22:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935550AbXGWUXI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 16:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935468AbXGWUXH
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 16:23:07 -0400
Received: from thunk.org ([69.25.196.29]:52303 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935132AbXGWUXE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 16:23:04 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1ID4YF-00064E-6K; Mon, 23 Jul 2007 16:30:43 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1ID4Py-0008BY-MD; Mon, 23 Jul 2007 16:22:10 -0400
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jan Engelhardt <jengelh@computergmbh.de>,
	Paul Mundt <lethal@linux-sh.org>, Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707231242090.3607@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53472>

On Mon, Jul 23, 2007 at 12:44:57PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 23 Jul 2007, Theodore Tso wrote:
> > 
> > Um, *I* never had the bad taste to import Linux kernels into CVS.  :-)
> 
> Ahh. I just checked. 
> 
> RCS.
> 
> There are old linux archive of yours that has some RCS files in it (0.10 
> and 0.12 at least)

Ah, yes, I used to use RCS in order to generate the patches that I
sent to use.  The RCS directories were short-term, and never lasted
longer until the next kernel release.  I'm kind of surprised that I
actually had archives that had RCS files, since tsx-11 should have
just had the original tar.gz files from ftp.cs.helsinki.edu.  Maybe
for some reason the original files got nuked and I replaced it with
one of my saved files at one point.  I dunno....

       	  	      	     	     - Ted
