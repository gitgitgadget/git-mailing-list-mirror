From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: "make test" works again (sort-of) on cygwin.
Date: Fri, 4 Jul 2008 02:04:54 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807040201500.2849@eeepc-johanness>
References: <486D0FFC.5090308@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Jul 04 02:06:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEYoI-0004t3-T1
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 02:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116AbYGDAE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 20:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752895AbYGDAE5
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 20:04:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:47034 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751136AbYGDAE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 20:04:57 -0400
Received: (qmail invoked by alias); 04 Jul 2008 00:04:55 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp004) with SMTP; 04 Jul 2008 02:04:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+jrZp8ciSjDXzPNr0cBVGlmLzMLR1jf8R+Nxxjy5
	tpTte4BkYz9z8x
X-X-Sender: user@eeepc-johanness
In-Reply-To: <486D0FFC.5090308@ramsay1.demon.co.uk>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87341>

Hi,

On Thu, 3 Jul 2008, Ramsay Jones wrote:

> Hi *,
> 
> Having upgraded to version 1.5.6 (via tarball), I can "make test" once
> again, without crashing my machine.

Earlier, I would have been more than ready to suggest using msysGit.  But 
as I became more than just frustrated with "users" (after all, Git users 
are supposed to be developers), I refrain more and more from doing so.

Having said that, you _might_ get lucky trying msysGit, even from Cygwin.  
Just do not complain to me when it does not work.

Ciao,
Dscho

P.S.: if it does not work, and you fix a few issues, but have problems 
with others, I might be more inclined to help you, just because you did 
fix some issues.
