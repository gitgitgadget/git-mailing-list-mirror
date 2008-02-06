From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Wed, 06 Feb 2008 12:48:55 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802061248280.2732@xanadu.home>
References: <20080203030054.GA18654@coredump.intra.peff.net>
 <20080203043310.GA5984@coredump.intra.peff.net>
 <alpine.LFD.1.00.0802040922480.3034@hp.linux-foundation.org>
 <7vr6fsk08w.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802041146060.3034@hp.linux-foundation.org>
 <alpine.LFD.1.00.0802041223080.3034@hp.linux-foundation.org>
 <7vir13g9hx.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802051300050.3110@woody.linux-foundation.org>
 <alpine.LSU.1.00.0802052228280.8543@racer.site>
 <alpine.LFD.1.00.0802051539570.2967@woody.linux-foundation.org>
 <20080206164303.GA1255@code-monkey.de>
 <alpine.LFD.1.00.0802061220590.2732@xanadu.home>
 <alpine.LFD.1.00.0802060942020.2967@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Tilman Sauerbeck <tilman@code-monkey.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 18:50:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMoPJ-0005lo-Jk
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 18:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391AbYBFRtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 12:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754403AbYBFRtE
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 12:49:04 -0500
Received: from relais.videotron.ca ([24.201.245.36]:21634 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377AbYBFRtB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 12:49:01 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JVT00M0UW5COD10@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 06 Feb 2008 12:48:49 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.1.00.0802060942020.2967@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72823>

On Wed, 6 Feb 2008, Linus Torvalds wrote:

> 
> 
> On Wed, 6 Feb 2008, Nicolas Pitre wrote:
> > 
> > Anyway, the author's date are not necessarily monotonic.
> 
> Git never even looks at the author date. Only the commit date matters.

OK good.


Nicolas
