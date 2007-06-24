From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH][RESEND] Escape some tilde characters causing spurious
 subscripts in documentation
Date: Sun, 24 Jun 2007 01:11:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706240109540.4059@racer.site>
References: <11826426733115-git-send-email-jasonsewall@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Jason Sewall <jasonsewall@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 02:12:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2FiG-0005ov-SB
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 02:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003AbXFXALk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 20:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752969AbXFXALk
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 20:11:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:59782 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752609AbXFXALj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 20:11:39 -0400
Received: (qmail invoked by alias); 24 Jun 2007 00:11:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 24 Jun 2007 02:11:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/oLPxwYfHoCHrWhojrIFIGxeME2fdx19ZROO06Z8
	LGBRJeAHNhhtuE
X-X-Sender: gene099@racer.site
In-Reply-To: <11826426733115-git-send-email-jasonsewall@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50762>

Hi,

On Sat, 23 Jun 2007, Jason Sewall wrote:

>  My second attempt at submitting a patch, this time with git-send-email 
> rather than copy-and-paste into gmail; let me know if this is a 
> reasonably presented patch. It is truly trivial, but getting those docs 
> cleaned up is important!

Applies cleanly (although the commit message now consists of one single 
long line).

I just checked with my copy of asciidoc, though, and there is no mangling 
going on, at least in git-bundle.html (which is the only file I checked). 
My asciidoc is version 8.2.1. What is yours?

Ciao,
Dscho
