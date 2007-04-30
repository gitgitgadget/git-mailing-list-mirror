From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Checklist clarifications: added "Commits", "Patch:"
 headings
Date: Mon, 30 Apr 2007 14:42:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704301442240.29859@racer.site>
References: <r6q2xgws.fsf@cante.net> <Pine.LNX.4.64.0704301333400.29859@racer.site>
 <abwqxe6t.fsf@cante.net> <Pine.LNX.4.64.0704301306340.2279@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Apr 30 14:43:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiVDe-00070r-AM
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 14:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423203AbXD3MnA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 08:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423209AbXD3MnA
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 08:43:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:45576 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423203AbXD3Mm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 08:42:59 -0400
Received: (qmail invoked by alias); 30 Apr 2007 12:42:57 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp031) with SMTP; 30 Apr 2007 14:42:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19XRpICJBFX2tPlFguPWFJb4TDykQKr4cgaDsdrCy
	zStj9yZjbckomL
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0704301306340.2279@reaper.quantumfyre.co.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45866>

Hi,

On Mon, 30 Apr 2007, Julian Phillips wrote:

> On Mon, 30 Apr 2007, Jari Aalto wrote:
> 
> > Is this workding okay?
> > 
> >        - send your patch to <git@vger.kernel.org> by using
> >          git-format-patch(1) with option "-M". If you use
> >          git-send-email(1), please test it first by sending
> >          email to yourself.
> 
> I don't want to seem picky, but that wording suggests to me that the -M
> option to format-patch magically sends patches to the list.  Why not just
> have:
> 
> 	- use "git format-patch -M" to create the patch
> 	- send your patch to <git@vger.kernel.org>. If you use
> 	  git-send-email(1), please test it first by sending
> 	  email to yourself.

Yes, I like that much better!

Thank you,
Dscho
