From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 21:18:53 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808282113410.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net>
 <7vr68b8q9p.fsf@gitster.siamese.dyndns.org> <20080827001705.GG23698@parisc-linux.org> <20080827225233.GA11005@flint.arm.linux.org.uk> <alpine.DEB.1.00.0808281733460.24820@pacific.mpi-cbg.de.mpi-cbg.de> <20080828161040.GH18340@parisc-linux.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Russell King <rmk@arm.linux.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org,
	users@kernel.org
To: Matthew Wilcox <matthew@wil.cx>
X-From: git-owner@vger.kernel.org Thu Aug 28 21:15:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYmxF-0001dd-5N
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 21:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049AbYH1TNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 15:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753112AbYH1TNp
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 15:13:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:54893 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752913AbYH1TNo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 15:13:44 -0400
Received: (qmail invoked by alias); 28 Aug 2008 19:13:41 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp041) with SMTP; 28 Aug 2008 21:13:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/7Lr49yE37dnC3Gdeb1ZVzJioGRCFSSbs5n4ZQr3
	dUUtzucpC1KF71
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20080828161040.GH18340@parisc-linux.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94117>

Hi,

On Thu, 28 Aug 2008, Matthew Wilcox wrote:

> On Thu, Aug 28, 2008 at 05:34:43PM +0200, Johannes Schindelin wrote:
> > On Wed, 27 Aug 2008, Russell King wrote:
> > > On Tue, Aug 26, 2008 at 06:17:05PM -0600, Matthew Wilcox wrote:
> > > > We didn't know the conversation was going on.  Why should we?  We only
> > > > use the tool, not develop it.  I'm also not on the mailing lists for
> > > > mutt, vim, gcc, binutils, openssh, grep, xchat, mozilla, gnome, xpdf or
> > > > any of the dozens of other programs I use on a daily basis.
> > > 
> > > Well said Matthew, as a git _user_ I completely agree.
> > 
> > So are you effectively saying that we should have asked on all the mailing 
> > list of existing and potential Git users to ask their opinions?
> 
> No.  I'm effectively saying that *you shouldn't break backwards
> compatibility*.  Ever.  It only annoys people.

This is something that comes out of a male cow, and from his back exit.

You are saying that something that was deprecated loooong time ago should 
be kept for backwards compatibility reasons.  That cannot hold, and you 
know that.

Anyway, you even failed to address my complaint, namely that Russell did 
not give us a _chance_.  He did not read the mailing list on which the 
issue was discussed -- and again, it is not a compatibility issue.  But he 
wanted to be notified.  Like they say, you cannot have your cake and eat 
it, too.

As to everybody who still wants to complain that git-xyyx is so much 
better than "git xyyx": face it, it's the better solution for almost 
everybody except for you.  Cope with it.

Oh, and I am sorry if it broke your scripts, but they are easy to fix.  I 
know, because I had to fix mine, too.

Ciao,
Dscho
