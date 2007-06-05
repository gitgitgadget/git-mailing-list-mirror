From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git requires zip?
Date: Tue, 5 Jun 2007 18:21:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706051819290.4046@racer.site>
References: <alpine.LFD.0.98.0706050908520.23741@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 05 19:23:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvclA-0005Zs-St
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 19:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681AbXFERXw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 13:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754178AbXFERXw
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 13:23:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:56538 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754202AbXFERXv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 13:23:51 -0400
Received: (qmail invoked by alias); 05 Jun 2007 17:23:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 05 Jun 2007 19:23:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+XhUMHCLqXyReXcVf0yEPfR9AsNTYp1mwH/cECwQ
	vawUArA6UpxaCo
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.98.0706050908520.23741@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49211>

Hi,

On Tue, 5 Jun 2007, Linus Torvalds wrote:

> It really shouldn't, but "make test" seems very unhappy if the machine 
> doesn't have it, and I don't see anything that disables the tests for 
> that case..

I seem to remember that I patched it already.

http://thread.gmane.org/gmane.comp.version-control.git/46854/focus=46899

Unfortunately, the patch was incorrect, and I forgot to do it properly. 
Will try this afternoon.

Sorry,
Dscho
