From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Remove deprecated commands from command list and update
 manpages
Date: Thu, 8 Nov 2007 15:19:13 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711081518590.4362@racer.site>
References: <Pine.LNX.4.64.0711072253580.4362@racer.site>
 <7vlk998u6r.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711080041120.4362@racer.site>
 <20071108145435.GA18727@diku.dk> <Pine.LNX.4.64.0711081517230.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Thu Nov 08 16:19:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq9AP-0000jp-FS
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 16:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600AbXKHPTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 10:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756651AbXKHPTV
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 10:19:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:36351 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754642AbXKHPTU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 10:19:20 -0500
Received: (qmail invoked by alias); 08 Nov 2007 15:19:18 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 08 Nov 2007 16:19:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19inHg4zcVikAFAMJdHBdmmDVNO1i9XKH7Iax/iZf
	Vn54/EXp8mE8JP
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0711081517230.4362@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64040>

Hi,

On Thu, 8 Nov 2007, Johannes Schindelin wrote:

> On Thu, 8 Nov 2007, Jonas Fonseca wrote:
> 
> > ... and remove manpages of commands that no longer exists.
> > 
> > Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> > ---
> >  Documentation/cmd-list.perl       |    5 ---
> 
> Maybe keep git-lost-found?
> 
> >  Documentation/git-local-fetch.txt |   66 -------------------------------------
> >  Documentation/git-ssh-fetch.txt   |   52 -----------------------------
> >  Documentation/git-ssh-upload.txt  |   48 ---------------------------
> >  Documentation/git-tar-tree.txt    |    2 +-
> >  Documentation/git-var.txt         |    3 +-
> 
> Last time I checked, git-var was still alive.

Oops.  Please ignore that one.

Ciao,
Dscho
