From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: auto gc again
Date: Wed, 19 Mar 2008 22:44:20 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803192243270.3983@racer.site>
References: <20080318180118.GC17940@kernel.dk> <alpine.LFD.1.00.0803181112270.3020@woody.linux-foundation.org> <20080318181948.GH17940@kernel.dk> <20080318182421.GI17940@kernel.dk> <alpine.LFD.1.00.0803181130240.3020@woody.linux-foundation.org>
 <20080318183906.GL17940@kernel.dk> <alpine.LSU.1.00.0803192121090.3983@racer.site> <20080319211436.GC17940@kernel.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 22:47:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc67k-00058d-E5
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 22:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762217AbYCSVoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 17:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938345AbYCSVob
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 17:44:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:45027 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S938332AbYCSVoW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 17:44:22 -0400
Received: (qmail invoked by alias); 19 Mar 2008 21:44:20 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp025) with SMTP; 19 Mar 2008 22:44:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+gONtQo1mgGF1XZpBOPt3qIJ0fFYeBWCezCg8IqU
	Ru9vKg+kc+Yv9k
X-X-Sender: gene099@racer.site
In-Reply-To: <20080319211436.GC17940@kernel.dk>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77562>

Hi,

On Wed, 19 Mar 2008, Jens Axboe wrote:

> On Wed, Mar 19 2008, Johannes Schindelin wrote:
> 
> > On Tue, 18 Mar 2008, Jens Axboe wrote:
> > 
> > > But you never answer the question on whether you really consider any 
> > > form of autopacking or auto gc sane? Next time some other limit is 
> > > added for auto gc, it'll be annoying once more.
> > 
> > The problem is: if people do not bother to "git gc" their 
> > repositories, git operations get slow.  We just had enough of that, 
> > and decided to "git gc" automatically for people who did not know 
> > about it, or were to lazy and then complained about git for being 
> > slow.
> 
> Sorry I disagree,

In this case, you can disagree as much as you want and you are still 
wrong.

The problem is that you are more intelligent than most others, and now you 
experience the downsides of it.

Ciao,
Dscho
