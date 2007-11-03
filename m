From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] git-fetch: more terse fetch output
Date: Sun, 4 Nov 2007 00:31:44 +0100
Organization: glandium.org
Message-ID: <20071103233144.GA16734@glandium.org>
References: <alpine.LFD.0.9999.0711030101340.21255@xanadu.home> <alpine.LFD.0.999.0711031229470.15101@woody.linux-foundation.org> <alpine.LFD.0.9999.0711031627000.21255@xanadu.home> <20071103204000.GA24959@glandium.org> <alpine.LFD.0.9999.0711031645350.21255@xanadu.home> <20071103210321.GA25685@glandium.org> <alpine.LFD.0.999.0711031546110.15101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jeff King <peff@peff.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 00:34:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoSVl-0006jT-OD
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 00:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756188AbXKCXe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 19:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756676AbXKCXe2
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 19:34:28 -0400
Received: from vawad.err.no ([85.19.200.177]:51778 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755213AbXKCXe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 19:34:27 -0400
Received: from aputeaux-153-1-38-67.w82-124.abo.wanadoo.fr ([82.124.130.67] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IoSV0-0006Th-Gd; Sun, 04 Nov 2007 00:34:04 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IoSSu-0004OF-Bp; Sun, 04 Nov 2007 00:31:44 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0711031546110.15101@woody.linux-foundation.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 5.5): Status=Yes hits=5.5 required=5.0 tests=RCVD_IN_SORBS_DUL,SPF_HELO_SOFTFAIL,SPF_SOFTFAIL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63323>

On Sat, Nov 03, 2007 at 03:48:42PM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 3 Nov 2007, Mike Hommey wrote:
> > 
> > How many grams in a kilogram ? How many meters in a kilometer ? How many
> > joule in a kilojoule ? ... How many bytes in a kilobyte ? Oh wait...
> 
> How many 'u's in the word "colour"?
> 
> Oh, wait - it depends on context, doesn't it?
> 
> kB is 1024 bytes. The fact that "k" means something else in other contexts 
> is simply irrelevant.

What about the fact that "kB" means different things depending whether it's
used for bandwidth or memory capacity ?
Does your brain have base 2 hard-coded so that you instantly know 50000000
bytes are 47.68MB ? Are people unable to do so pondscum ?

Mike
