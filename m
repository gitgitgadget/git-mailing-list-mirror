From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Guided merge with override
Date: Tue, 17 Jun 2008 11:17:55 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806171117280.6439@racer>
References: <93c3eada0806152116v2cef4035u272dc1a26005661a@mail.gmail.com>  <20080616092554.GB29404@genesis.frugalware.org>  <48563D6C.8060704@viscovery.net>  <bd6139dc0806161521p3667a44ble8573be1569986a0@mail.gmail.com>  <485756AE.9050904@viscovery.net> 
 <bd6139dc0806170153h4fba934ei62cb06e98e0280fd@mail.gmail.com>  <alpine.DEB.1.00.0806171045570.6439@racer> <bd6139dc0806170253r5ea7844dm71d0bc407da2acc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Geoff Russell <geoffrey.russell@gmail.com>, git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Tue Jun 17 12:20:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8YIn-0002T0-7G
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 12:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782AbYFQKTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 06:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753702AbYFQKTd
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 06:19:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:57867 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751353AbYFQKTc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 06:19:32 -0400
Received: (qmail invoked by alias); 17 Jun 2008 10:19:30 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp003) with SMTP; 17 Jun 2008 12:19:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19dbMsLuXhdRAMgJQVW+TTWY4UpIM/7txKeCLRaWu
	H2ZkW4PUF+rgUh
X-X-Sender: gene099@racer
In-Reply-To: <bd6139dc0806170253r5ea7844dm71d0bc407da2acc7@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85284>

Hi,

On Tue, 17 Jun 2008, Sverre Rabbelier wrote:

> On Tue, Jun 17, 2008 at 11:48 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > Of course, I think that a better way would be to ask "git diff 
> > --name-only --diff-filter=U".
> 
> Hmmm, not having an unfinished merge at hand, would that require the
> sed on top too?

Nope.  The "--name-only" says it will print only the name.

Ciao,
Dscho
