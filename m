From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: New mailmap file for the kernel
Date: Mon, 28 Jul 2008 13:23:57 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807281321540.2725@eeepc-johanness>
References: <9e4733910807272145y5b67112er4b90cc36141663c1@mail.gmail.com>  <alpine.DEB.1.00.0807281251000.2725@eeepc-johanness> <bd6139dc0807280411k3a283c5dr4b874342aab167dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Mon Jul 28 13:23:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNQpU-0003pR-JJ
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 13:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbYG1LWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 07:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbYG1LWw
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 07:22:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:38950 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750720AbYG1LWv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 07:22:51 -0400
Received: (qmail invoked by alias); 28 Jul 2008 11:22:49 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp023) with SMTP; 28 Jul 2008 13:22:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/qnTxrPGbqfdvXodny4j3NkoOQoBOSHd9LEIug/A
	zuU8Sr5hyt8TAb
X-X-Sender: user@eeepc-johanness
In-Reply-To: <bd6139dc0807280411k3a283c5dr4b874342aab167dc@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90442>

Hi,

On Mon, 28 Jul 2008, Sverre Rabbelier wrote:

> On Mon, Jul 28, 2008 at 12:53, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Unless somebody forgets, right?
> 
> Unless there is a pre-commit hook that prevents you from committing
> when you are not in the mailmap.

And how exactly do you plan to make sure everybody has that hook 
installed?

Also, it would be a major hassle, just for the benefits of statistics 
(which, funnily enough, not everybody cares about).

> > Also note that in a distributed world, you cannot properly speak of a 
> > "new developer".
> 
> Yet we do it all the time on git.git ;).

But we are not truly distributed.  Our community is small enough, and our 
maintainer good enough, that we do have a single upstream essentially.  We 
do not even have lieutenants through which new developers could come (and 
therefore would be old developers once they hit master).

Ciao,
Dscho
