From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] git/gitweb.git repository
Date: Sat, 1 Sep 2007 03:31:59 +0200
Message-ID: <20070901013159.GP1219@pasky.or.cz>
References: <767502.77573.qm@web31812.mail.mud.yahoo.com> <Pine.LNX.4.64.0709010224410.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org,
	jnareb@gmail.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 01 03:32:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRHqL-0002tb-Gg
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 03:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbXIABcG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 21:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbXIABcF
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 21:32:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53413 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106AbXIABcE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 21:32:04 -0400
Received: (qmail 3870 invoked by uid 2001); 1 Sep 2007 03:31:59 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709010224410.28586@racer.site>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57242>

  Hi,

On Sat, Sep 01, 2007 at 03:25:16AM CEST, Johannes Schindelin wrote:
> On Fri, 31 Aug 2007, Luben Tuikov wrote:
> 
> > --- Petr Baudis <pasky@suse.cz> wrote:
> > >   Hi,
> > > 
> > >   due to popular (Junio's) demand, I have set up a gitweb-oriented fork
> > > of git at repo.or.cz:
> > > 
> > > 	http://repo.or.cz/w/git/gitweb.git
> > > 
> > >   It is meant as a hub for various gitweb-related patches and
> > > development efforts. So far it is pre-seeded by the patches repo.or.cz's
> > > gitweb uses.
> > 
> > Is this right?
> > 
> > So what's the review process now?
> 
> Umm.  Pasky set it up, so it's Pasky who decides what goes in and what 
> not.  What exactly is your problem?

  Junio will pull from it, so he has full right to ask. :-) As I wrote
in the web README, to enter #next your patch should see some git@ review;
that holds for repo.or.cz patches as well as for any other patches. I
suppose we will sort out the exact distinction between #next and #master
on the fly; the general idea is that patches that go on #master have
more or less approached perfectness. ;-)

-- 
				Petr "Pasky" Baudis
Early to rise and early to bed makes a male healthy and wealthy and dead.
                -- James Thurber
