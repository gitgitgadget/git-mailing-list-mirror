From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Memory overrun in http-push.c
Date: Wed, 28 Feb 2007 16:42:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702281642420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070228151516.GC57456@codelabs.ru> <200702281541.41164.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1880772043-1172677372=:22628"
Cc: git@vger.kernel.org, Eygene Ryabinkin <rea-git@codelabs.ru>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 16:43:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMQxG-00059I-Ie
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 16:42:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbXB1Pm5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 10:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbXB1Pm5
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 10:42:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:38208 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751831AbXB1Pm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 10:42:56 -0500
Received: (qmail invoked by alias); 28 Feb 2007 15:42:55 -0000
X-Provags-ID: V01U2FsdGVkX1+W3KkqKqqWzCX2omkscaKTw4gsMr3Wgdx+kyygq9
	qs9g==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200702281541.41164.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40945>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1880772043-1172677372=:22628
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 28 Feb 2007, Andy Parkins wrote:

> On Wednesday 2007 February 28 15:15, Eygene Ryabinkin wrote:
> > --- http-push.c.orig    Wed Feb 28 15:15:01 2007
> > +++ http-push.c Wed Feb 28 15:15:21 2007
> > @@ -1295,7 +1295,7 @@
> 
> A patch for git that wasn't made with git.
> 
> Don't take this the wrong way Eygene, but why?

Old habits die hard?

Ciao,
Dscho

---1148973799-1880772043-1172677372=:22628--
