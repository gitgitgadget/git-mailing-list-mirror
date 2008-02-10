From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Add "--show-all" revision walker flag for debugging
Date: Sun, 10 Feb 2008 01:30:30 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802100130090.11591@racer.site>
References: <alpine.LFD.1.00.0802091341210.2896@woody.linux-foundation.org> <alpine.LSU.1.00.0802100110450.11591@racer.site> <alpine.LFD.1.00.0802092016540.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 02:31:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO129-0001OI-Ry
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 02:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757301AbYBJBaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 20:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752520AbYBJBaa
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 20:30:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:46708 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752398AbYBJBa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 20:30:29 -0500
Received: (qmail invoked by alias); 10 Feb 2008 01:30:27 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp050) with SMTP; 10 Feb 2008 02:30:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18j8ccibskjuQWckhVTv8fh3PYWD7uk8Y0xKpSgUg
	b22ZdOlswMfDP0
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0802092016540.2732@xanadu.home>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73287>

Hi,

On Sat, 9 Feb 2008, Nicolas Pitre wrote:

> I, too, have some reservations about adding any kind of generation 
> header to commit objects.  First because it can be generated and 
> maintained locally, just like the pack index.  But also because its 
> usefulness has not been proven in all possible graph topologies, and 
> adding it to the commit header pretty much deny any further 
> modifications/improvements on it, if for example some other kind of 
> generation notation becomes advantageous to use.

I fully agree.

Ciao,
Dscho
