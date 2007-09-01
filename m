From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [ANNOUNCE] git/gitweb.git repository
Date: Fri, 31 Aug 2007 19:06:40 -0700 (PDT)
Message-ID: <233630.70682.qm@web31809.mail.mud.yahoo.com>
References: <Pine.LNX.4.64.0709010224410.28586@racer.site>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org, jnareb@gmail.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 01 04:07:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRIOC-0007Gn-OF
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 04:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbXIACGm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 22:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbXIACGl
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 22:06:41 -0400
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:30519 "HELO
	web31809.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750921AbXIACGl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Aug 2007 22:06:41 -0400
Received: (qmail 71014 invoked by uid 60001); 1 Sep 2007 02:06:40 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=zpzQj6Y6t466mI5HxzNF8oi3PlmzJtOn4Z4caK87Qg3DEZbpyHeFaSxEn6Dh8stUKgIj9wPzG7joKUiVlbat8pNXjV6AVHYfVwc2/NttEXuvCUcju/heSYpXHpmjd6HVmlQ75eVJKERRF0tufJ3ZiP8c0theSPJ+mLTDWl+iQMU=;
X-YMail-OSG: R63klcwVM1kTNLyF0UMOsATZAwSgHnRg2AnImJujUSh0G4y5CtFVGK7n5kou5Y.a1H7NB_GGS5VDLZdcDQSV00La67C4GeVP9mXk55HZlj3AyqQ-
Received: from [64.215.88.90] by web31809.mail.mud.yahoo.com via HTTP; Fri, 31 Aug 2007 19:06:40 PDT
In-Reply-To: <Pine.LNX.4.64.0709010224410.28586@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57245>

--- Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Hi,
> 
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

That's perfectly fine as long as Junio doesn't pull from it ever.

Now since Junio is going to pull from it, there needs to be some
sort of accountability.

    Luben
