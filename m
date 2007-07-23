From: Theodore Tso <tytso@mit.edu>
Subject: Re: Git tree for old kernels from before the current tree
Date: Mon, 23 Jul 2007 14:57:32 -0400
Message-ID: <20070723185732.GB30165@thunk.org>
References: <9e4733910707221349s462aa11bj714956f7cdc72aac@mail.gmail.com> <Pine.LNX.4.64.0707222257540.32367@fbirervta.pbzchgretzou.qr> <20070722211314.GA13850@linux-sh.org> <Pine.LNX.4.64.0707222344540.32367@fbirervta.pbzchgretzou.qr> <Pine.LNX.4.64.0707230000170.32367@fbirervta.pbzchgretzou.qr> <46A3D5EA.2050600@zytor.com> <alpine.LFD.0.999.0707230950340.3607@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Jan Engelhardt <jengelh@computergmbh.de>,
	Paul Mundt <lethal@linux-sh.org>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 20:58:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID36W-0007hX-Qx
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 20:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761197AbXGWS5z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 14:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758767AbXGWS5z
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 14:57:55 -0400
Received: from thunk.org ([69.25.196.29]:36975 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756983AbXGWS5y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 14:57:54 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1ID3EM-0005im-NP; Mon, 23 Jul 2007 15:06:06 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1ID364-0004qb-MN; Mon, 23 Jul 2007 14:57:32 -0400
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jan Engelhardt <jengelh@computergmbh.de>,
	Paul Mundt <lethal@linux-sh.org>, Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707230950340.3607@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53461>

On Mon, Jul 23, 2007 at 09:55:24AM -0700, Linus Torvalds wrote:
> 
> I actually tried to get something like this together back in the BK days 
> and early in the SCO saga. It was pretty painful to try to find all the 
> historic trees and patches - they're all in different format, and some of 
> them are unreliable (ie CVS imports by people like Ted).

Um, *I* never had the bad taste to import Linux kernels into CVS.  :-)

I'm pretty sure we never had anything like that on tsx-11.mit.edu, either.

    	   	   	     	      	   - Ted
