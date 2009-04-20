From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What are branches?
Date: Mon, 20 Apr 2009 21:19:10 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904202117010.6771@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de> <20090420113216.GC25059@dpotapov.dyndns.org> <49EC6596.8060208@drmicha.warpmail.net> <20090420132414.GD25059@dpotapov.dyndns.org> <alpine.DEB.1.00.0904201621290.6771@intel-tinevez-2-302>
 <20090420184746.GG25059@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 21:21:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvz36-000378-2B
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 21:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124AbZDTTTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 15:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753989AbZDTTTU
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 15:19:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:34753 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753602AbZDTTTU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 15:19:20 -0400
Received: (qmail invoked by alias); 20 Apr 2009 19:19:14 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp067) with SMTP; 20 Apr 2009 21:19:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX180OQJ0uS80yVZumN38R2k24EldwEk01r0nLDY8PT
	kg2Xe4tQ0YjcmA
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090420184746.GG25059@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117024>

Hi,

On Mon, 20 Apr 2009, Dmitry Potapov wrote:

> On Mon, Apr 20, 2009 at 04:25:38PM +0200, Johannes Schindelin wrote:
> > 
> > On Mon, 20 Apr 2009, Dmitry Potapov wrote:
> > 
> > > When you create a new commit, it is always belong to _one_ branch 
> > > and never to two or more branches.
> > 
> > Certainly you forgot about detached HEADs?
> 
> I suppose it is a branch without any name given to it, but it is an 
> advanced feature. I don't think many beginners know about it, so it is 
> something that can confuse beginners.

I'm sorry, the direction of this discussion does not please me.

The purpose of my message was to make Git old-timers _aware_ of the 
problems newbies have with our notion of branches.  And a wish to come up 
with less confusing documentation.

The purpose was not to discuss at length what branches are in Git (and 
the intended discussion was certainly not about CVS!).

Ciao,
Dscho
