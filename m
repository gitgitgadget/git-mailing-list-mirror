From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] git-fetch: more terse fetch output
Date: Sat, 3 Nov 2007 22:03:21 +0100
Organization: glandium.org
Message-ID: <20071103210321.GA25685@glandium.org>
References: <alpine.LFD.0.9999.0711030101340.21255@xanadu.home> <alpine.LFD.0.999.0711031229470.15101@woody.linux-foundation.org> <alpine.LFD.0.9999.0711031627000.21255@xanadu.home> <20071103204000.GA24959@glandium.org> <alpine.LFD.0.9999.0711031645350.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Nov 03 22:06:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoQBy-0008Ic-BH
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 22:06:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756391AbXKCVFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 17:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756677AbXKCVFv
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 17:05:51 -0400
Received: from vawad.err.no ([85.19.200.177]:37676 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756391AbXKCVFu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 17:05:50 -0400
Received: from aputeaux-153-1-38-67.w82-124.abo.wanadoo.fr ([82.124.130.67] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IoQBP-0005Gh-UL; Sat, 03 Nov 2007 22:05:34 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IoQ9J-0006kh-Km; Sat, 03 Nov 2007 22:03:21 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0711031645350.21255@xanadu.home>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63314>

On Sat, Nov 03, 2007 at 04:50:54PM -0400, Nicolas Pitre wrote:
> [ heh, I knew someone would say something ]
> 
> Yes, to me, 1MB is 1024 KB.  Always been, until those idiotic hard disk 
> manufacturers decided to redefine the common interpretation of what 
> everyone else used to consider what a MB is just to boost their 
> marketing claims.

How many grams in a kilogram ? How many meters in a kilometer ? How many
joule in a kilojoule ? ... How many bytes in a kilobyte ? Oh wait...

And you know what ? It's not only a matter of hard disk manufacturers.

How fast is gigabit ethernet ? Yep, 1000000000 bits/s
How big would people say a 44000000 bytes file is ? 44MB or 42MB ?
And my favourite: How many bytes in a 1.44MB floppy disk ? 1474560, that
is, 1.44 * 1024000.

Those who made this big mess are the ones who decided a KB was 1024
bytes, not the others.

Mike
