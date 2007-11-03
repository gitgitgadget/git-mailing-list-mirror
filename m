From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] git-fetch: more terse fetch output
Date: Sat, 3 Nov 2007 21:40:00 +0100
Organization: glandium.org
Message-ID: <20071103204000.GA24959@glandium.org>
References: <alpine.LFD.0.9999.0711030101340.21255@xanadu.home> <alpine.LFD.0.999.0711031229470.15101@woody.linux-foundation.org> <alpine.LFD.0.9999.0711031627000.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Nov 03 21:43:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoPpi-0002uy-AE
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 21:43:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756995AbXKCUmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 16:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756482AbXKCUmq
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 16:42:46 -0400
Received: from vawad.err.no ([85.19.200.177]:56164 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756143AbXKCUmq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 16:42:46 -0400
Received: from aputeaux-153-1-38-67.w82-124.abo.wanadoo.fr ([82.124.130.67] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IoPop-0004Yu-RV; Sat, 03 Nov 2007 21:42:14 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IoPmi-0006W6-PF; Sat, 03 Nov 2007 21:40:01 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0711031627000.21255@xanadu.home>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63311>

On Sat, Nov 03, 2007 at 04:30:27PM -0400, Nicolas Pitre wrote:
> On Sat, 3 Nov 2007, Linus Torvalds wrote:
> 
> > 
> > 
> > On Sat, 3 Nov 2007, Nicolas Pitre wrote:
> > > 
> > > Receiving objects: 100% (5439/5439), 1.60 MiB | 636 KiB/s, done.
> > 
> > I mostly like this, but can we please just use "MB/kB" instead of 
> > "MiB/KiB"?
> > 
> > I hope it was some kind of joke on crazy EU bureaucrats that just wasn't 
> > caught in time.
> 
> I don't care either ways.  In fact my own preference is for MB/kB, but 
> if I had used that first I'm sure someone else would have asked for the 
> purist notations.

As far as you don't claim 1MB is 1024KB, it's okay.

Mike
