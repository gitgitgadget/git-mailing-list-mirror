From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: monotone is slow
Date: Fri, 16 Feb 2007 23:47:57 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702162347430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910702161320s12ba7a2boadaf075993579900@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 16 23:48:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIBs3-0007kV-DO
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 23:48:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbXBPWsA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 17:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbXBPWsA
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 17:48:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:47848 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751563AbXBPWr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 17:47:58 -0500
Received: (qmail invoked by alias); 16 Feb 2007 22:47:57 -0000
X-Provags-ID: V01U2FsdGVkX1/D4qZq4KbDhqrWltSDohR0VhELB7CgJdsMc62lNP
	jpuw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <9e4733910702161320s12ba7a2boadaf075993579900@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39955>

Hi,

On Fri, 16 Feb 2007, Jon Smirl wrote:

> 45 CPU minutes to do a pull. About 2hrs real time.
> 
> jonsmirl@jonsmirl:~$ ps aux | grep mtn
> jonsmirl  8382 80.5  4.4 131444 115204 pts/0   S+   14:54  45:44 mtn pull
> 
> And it worked, nothing was wrong. 1,500 revs pulled.
> Let's convert the world to git.

But does it cook dinner?

Ciao,
Dscho
