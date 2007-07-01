From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cvstrack: work on imported cvs and other git branches
Date: Sun, 1 Jul 2007 18:53:45 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707011852531.4438@racer.site>
References: <11832957963860-git-send-email-prohaska@zib.de>
 <Pine.LNX.4.64.0707011533370.4438@racer.site> <4880FDC4-BAD5-49B4-871B-98259D691449@zib.de>
 <Pine.LNX.4.64.0707011710480.4438@racer.site> <4ED65855-7B87-43C6-B5F1-162FC9A1CBF0@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Jul 01 19:54:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I53cZ-0001uT-Dy
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 19:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121AbXGARxw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 13:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753571AbXGARxw
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 13:53:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:55459 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753030AbXGARxw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 13:53:52 -0400
Received: (qmail invoked by alias); 01 Jul 2007 17:53:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 01 Jul 2007 19:53:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+MWcZsZYKMrU5RoRQnv4SjCXWN9E2YxcGHIMGKYz
	6EAVCaHkNFQRps
X-X-Sender: gene099@racer.site
In-Reply-To: <4ED65855-7B87-43C6-B5F1-162FC9A1CBF0@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51312>

Hi,

On Sun, 1 Jul 2007, Steffen Prohaska wrote:

> The background is, I plan to convince approximately 60 developers
> to migrate from CVS to git and I'm searching for a way to start the
> transition with some beta testers, while maintaining full cvs
> infrastructure in place for the remaining users.

Why not just cvsimporting into git, and then replace the CVS server with 
git-cvsserver? That's what I did.

Ciao,
Dscho
